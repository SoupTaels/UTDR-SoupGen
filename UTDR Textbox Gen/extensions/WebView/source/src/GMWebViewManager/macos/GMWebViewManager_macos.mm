// GMWebViewManager_macos.mm
//
// Compile as Objective-C++ (.mm) on macOS only.
// Requires:  Cocoa.framework  WebKit.framework
//

#include <iomanip>
#include <fstream>
#include <sstream>
#include <future>

#include "GMWebViewManager.h"
#include "common/GMWebViewManager_utils.h"
#include <nlohmann/json.hpp>

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

using namespace webviewcpp;
using namespace webviewcpp::utils;

// ──────────────────────────────────────────────────────────────
// helpers
// ──────────────────────────────────────────────────────────────
static inline void runOnMain(const dispatch_block_t b)
{
    if (NSThread.isMainThread) b();
    else dispatch_async(dispatch_get_main_queue(), b);
}

static inline NSString* nsstr(const std::string& s)
{
    return [NSString stringWithUTF8String:s.c_str()];
}

// ──────────────────────────────────────────────────────────────
//  constant JS that injects GMUI (identical to Windows build)
// ──────────────────────────────────────────────────────────────
static const char kInjectJS[] = R"JS(
    (function(){
        // send message to native (bound via bind("gm", ...))
        function post(m) {
            try {
                const args = Array.from(arguments);
                window.webkit.messageHandlers.gm.postMessage(JSON.stringify(args));
            } catch (e) {
                console.log('[GMInject] bridge unavailable', e);
            }
        }

        // Create a window level redirect
        window.gm_post = post;

        // mark that injection succeeded (easy sanity check)
        post('__injected');

        // ─────────────────────────────────────────────────────────────
        //  Navigation / title / params tracking (event-driven)
        //  - no body spam
        //  - still emits __load_start/__load_end like before
        //  - emits __url/__title on actual URL transitions
        // ─────────────────────────────────────────────────────────────
        document.addEventListener('DOMContentLoaded', ()=> {
            post('__load_end');

            const html = document.body ? document.body.innerHTML : '';
            post('__body:' + html);
        });

        post('__load_start');

        function sendUrlTitle() {
            try {
            const href = String(location.href || '');
            if (href !== window.__gm_href) {
                window.__gm_href = href;
                post('__url:' + href);
                post('__title:' + (document.title || ''));
                // keep gmwebview:// behavior
                if (href.startsWith('gmwebview://')) {
                post('__gm:' + decodeURIComponent(href.substr(12)));
                }
            } else {
                // title can change without URL change
                const t = String(document.title || '');
                if (t !== window.__gm_title) {
                window.__gm_title = t;
                post('__title:' + t);
                }
            }
            } catch(e) {}
        }

        // Hook history API so SPAs trigger events immediately
        (function(){
            try {
            const _ps = history.pushState;
            const _rs = history.replaceState;
            history.pushState = function(){
                const r = _ps.apply(this, arguments);
                setTimeout(sendUrlTitle, 0);
                return r;
            };
            history.replaceState = function(){
                const r = _rs.apply(this, arguments);
                setTimeout(sendUrlTitle, 0);
                return r;
            };
            window.addEventListener('popstate', function(){ setTimeout(sendUrlTitle, 0); }, true);
            window.addEventListener('hashchange', function(){ setTimeout(sendUrlTitle, 0); }, true);
            } catch(e) {}
        })();

        // initial + slow fallback poll (keeps your robustness, less spam)
        sendUrlTitle();
        setInterval(sendUrlTitle, 1000);

        // ─────────────────────────────────────────────────────────────
        //  Async “getters” (optional): request body/url/title/params on demand
        //  Protocol: page posts "__resp:<rid>:<key>:<value>"
        //  <value> is a JSON string literal (safe for arbitrary text)
        // ─────────────────────────────────────────────────────────────
        function jsonStringifySafe(v) {
            try { return JSON.stringify(String(v)); } catch(e) { return "\"\""; }
        }

        window.GMUI_REQ = window.GMUI_REQ || {
            body: function(rid){
            try {
                const html = document.body ? document.body.innerHTML : '';
                post('__resp:' + rid + ':body:' + jsonStringifySafe(html));
            } catch(e) {
                post('__resp:' + rid + ':body:""');
            }
            },
            url: function(rid){
            try { post('__resp:' + rid + ':url:' + jsonStringifySafe(location.href || '')); }
            catch(e){ post('__resp:' + rid + ':url:""'); }
            },
            title: function(rid){
            try { post('__resp:' + rid + ':title:' + jsonStringifySafe(document.title || '')); }
            catch(e){ post('__resp:' + rid + ':title:""'); }
            },
            params: function(rid){
            try {
                const href = String(location.href || '');
                const q = href.indexOf('?');
                const h = href.indexOf('#');

                let query = '';
                if (q >= 0) query = href.substring(q + 1, h >= 0 ? h : undefined);

                let hash = '';
                if (h >= 0) hash = href.substring(h + 1);

                // You can pick a format. This is simple:
                const combined = query + (hash ? ('#' + hash) : '');
                post('__resp:' + rid + ':params:' + jsonStringifySafe(combined));
            } catch(e){
                post('__resp:' + rid + ':params:""');
            }
            }
        };

        // ─────────────────────────────────────────────────────────────
        //  Body change detection (MutationObserver + debounce)
        //  - emits "__body_dirty" (debounced)
        //  - optional: auto-push "__body:<json>" under size cap
        // ─────────────────────────────────────────────────────────────
        (function(){
            const DEBOUNCE_MS = 350;

            // If you want auto-push body, set true.
            // If false, only sends __body_dirty (recommended).
            const AUTO_PUSH_BODY = false;

            // If auto-push is enabled, cap size to avoid huge bridge messages.
            const MAX_BODY_CHARS = 200000; // tune as needed

            let timer = 0;
            let pending = false;

            function schedule() {
            if (pending) return;
            pending = true;
            if (timer) clearTimeout(timer);
            timer = setTimeout(flush, DEBOUNCE_MS);
            }

            function flush() {
            pending = false;
            timer = 0;

            // Always signal "something changed"
            post('__body_dirty');

            if (!AUTO_PUSH_BODY) return;

            try {
                const html = document.body ? document.body.innerHTML : '';
                if (html && html.length <= MAX_BODY_CHARS) {
                // reuse your safe JSON wrapper
                post('__body:' + jsonStringifySafe(html));
                } else {
                post('__body_toolarge:' + (html ? html.length : 0));
                }
            } catch(e) {}
            }

            function startObserver(root) {
            try {
                const obs = new MutationObserver(schedule);
                obs.observe(root, {
                subtree: true,
                childList: true,
                characterData: true
                });
                window.__gm_bodyObs = obs;
            } catch(e) {}
            }

            function boot() {
            const root = document.body || document.documentElement;
            if (root) startObserver(root);
            }

            if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', boot, { once: true });
            } else {
            boot();
            }
        })();

        // ─────────────────────────────────────────────────────────────
        //  GMUI buttons (idempotent upsert, no remove/recreate)
        // ─────────────────────────────────────────────────────────────

        // DP -> CSS px (optionally scale by devicePixelRatio; set DPR=1 to disable)
        const DPR = window.devicePixelRatio || 1;
        function px(dp){ return Math.round(dp * DPR); }

        // Bit masks roughly matching Android's Gravity (support LEFT/RIGHT and START/END)
        const G_CENTER_H = 0x01,        // CENTER_HORIZONTAL
                G_CENTER_V = 0x10,      // CENTER_VERTICAL
                G_LEFT     = 0x03,
                G_RIGHT    = 0x05,
                G_START    = 0x800003,
                G_END      = 0x800005,
                G_TOP      = 0x30,
                G_BOTTOM   = 0x50;

        // Masks for just the gravity component:
        const H_MASK = 0x07;  // bits 0-2
        const V_MASK = 0x70;  // bits 4-6

        function applyGravity(el, g, m) {
            el.style.top = el.style.bottom = el.style.left = el.style.right = '';
            // preserve any existing translateZ layer hint:
            const hadZ = (el.dataset && el.dataset.tz === '1');
            el.style.transform = '';

            // vertical
            switch (g & V_MASK) {
            case G_CENTER_V:
                el.style.top = '50%';
                el.style.transform += ' translateY(-50%)';
                break;
            case G_BOTTOM:
                el.style.bottom = px(m.b) + 'px';
                break;
            default:
                el.style.top = px(m.t) + 'px';
                break;
            }

            // horizontal
            switch (g & H_MASK) {
            case G_CENTER_H:
                el.style.left = '50%';
                el.style.transform += ' translateX(-50%)';
                break;
            case G_RIGHT:
                el.style.right = px(m.r) + 'px';
                break;
            default:
                el.style.left = px(m.l) + 'px';
                break;
            }

            el.style.transform = (el.style.transform || '').trim();
            if (hadZ) el.style.transform = (el.style.transform ? (el.style.transform + ' ') : '') + 'translateZ(0)';
        }

        function upsertBtn(id) {
            let el = document.getElementById('gm_btn_' + id);
            if (!el) {
            el = document.createElement('img');
            el.id = 'gm_btn_' + id;
            el.style.position = 'fixed';
            el.style.zIndex = '2147483647';
            el.style.pointerEvents = 'auto';
            el.style.cursor = 'pointer';
            el.style.userSelect = 'none';
            el.style.webkitUserSelect = 'none';
            el.style.touchAction = 'manipulation';
            // layer hint (keep it stable)
            el.dataset.tz = '1';
            el.style.transform = 'translateZ(0)';

            el.addEventListener('click', function(ev){
                try { ev.preventDefault(); ev.stopPropagation(); } catch(e) {}
                if (el.dataset.autoclose === '1') post('__close');
                else post('__btn:' + id);
            }, true);

            // Ensure body exists
            (document.body || document.documentElement).appendChild(el);
            }
            return el;
        }

        window.GMUI = window.GMUI || {
            // add/update using gravity + margins, size (dp), alpha, asset URL/URI
            addG: function(id, src, sizeDp, gravity, m){
            const el = upsertBtn(id);
            el.src = src || '';
            el.style.width  = px(sizeDp) + 'px';
            el.style.height = px(sizeDp) + 'px';

            el.dataset.mode    = 'gravity';
            el.dataset.gravity = String(gravity|0);
            el.dataset.margins = JSON.stringify(m || {l:12,t:12,r:12,b:12});

            applyGravity(el, gravity|0, m || {l:12,t:12,r:12,b:12});
            },

            // switch to absolute positioning (xDp,yDp)
            pos: function(id, xDp, yDp){
            const el = document.getElementById('gm_btn_'+id);
            if(!el) return;
            el.dataset.mode='absolute';
            el.style.left = px(xDp)+'px';
            el.style.top  = px(yDp)+'px';
            el.style.right = el.style.bottom = 'auto';
            },

            // restore gravity mode
            gravity: function(id, gravity){
            const el = document.getElementById('gm_btn_'+id);
            if(!el) return;
            el.dataset.mode='gravity';
            el.dataset.gravity=String(gravity|0);
            let m = el.dataset.margins ? JSON.parse(el.dataset.margins) : {l:12,t:12,r:12,b:12};
            applyGravity(el, gravity|0, m);
            },

            margins: function(id, lDp,tDp,rDp,bDp){
            const el = document.getElementById('gm_btn_'+id);
            if(!el) return;
            let m = { l:lDp, t:tDp, r:rDp, b:bDp };
            el.dataset.margins = JSON.stringify(m);
            if (el.dataset.mode === 'gravity') {
                const g = parseInt(el.dataset.gravity || 0,10);
                applyGravity(el, g, m);
            }
            },

            size: function(id, sizeDp){
            const el = document.getElementById('gm_btn_'+id);
            if(!el) return;
            el.style.width  = px(sizeDp) + 'px';
            el.style.height = px(sizeDp) + 'px';
            },

            alpha: function(id,a){ const el=document.getElementById('gm_btn_'+id); if(el) el.style.opacity=String(a); },
            show:  function(id){ const el=document.getElementById('gm_btn_'+id); if(el) el.style.display=''; },
            hide:  function(id){ const el=document.getElementById('gm_btn_'+id); if(el) el.style.display='none'; },
            asset: function(id, src){ const el=document.getElementById('gm_btn_'+id); if(el) el.src=src||''; },
            autoClose: function(id, flag){ const el=document.getElementById('gm_btn_'+id); if(el) el.dataset.autoclose = flag ? '1' : '0'; },
            rem:   function(id){ const el=document.getElementById('gm_btn_'+id); if(el) el.remove(); },
            remAll:function(){ document.querySelectorAll('[id^=gm_btn_]').forEach(e=>e.remove()); }
        };
    })();
)JS";

// ──────────────────────────────────────────────────────────────
//  mac-specific state (one singleton instance anyway)
// ──────────────────────────────────────────────────────────────

namespace {
struct MacState {
    __strong NSWindow     *win  = nil;
    __strong WKWebView    *wk   = nil;
    id            nav  = nil;   // delegate / message handler
};
static MacState g;
} // unnamed

// YouTube IFrame API host page (mirrors the Windows "appassets" approach).
static const char* kYT_IFrameApiHostHTML = R"HTML(
<!doctype html>
<html style="width:100%;height:100%">
<head>
  <meta charset="utf-8">
  <meta name="referrer" content="strict-origin-when-cross-origin">
  <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1">
  <style>
    html, body { margin:0; width:100%; height:100%; overflow:hidden; background:#000; }
    #player { width:100%; height:100%; }
    #err { position:fixed; left:0; right:0; bottom:0; padding:8px 10px;
           font:12px/1.3 sans-serif; color:#fff; background:rgba(0,0,0,.6);
           display:none; }
  </style>
</head>
<body>
  <div id="player"></div>
  <div id="err"></div>
  <script>
    (function(){
      const params = new URLSearchParams(location.search);
      const videoId = (params.get("id") || "").trim();
      const err = document.getElementById("err");
      function show(msg) { err.textContent = msg; err.style.display = "block"; }
      if (!videoId) { show("Missing ?id=VIDEO_ID"); return; }
      const tag = document.createElement("script");
      tag.src = "https://www.youtube.com/iframe_api";
      tag.onerror = () => show("Failed to load YouTube IFrame API.");
      document.head.appendChild(tag);
      let player = null;
      window.onYouTubeIframeAPIReady = function() {
        try {
          player = new YT.Player("player", {
            width: "100%", height: "100%", videoId: videoId,
            playerVars: { autoplay: 1, playsinline: 1, rel: 0 },
            events: {
              onReady: (e) => { try { e.target.playVideo(); } catch(_) {} },
              onError: (e) => show("YouTube player error: " + e.data)
            }
          });
        } catch (ex) {
          show("Failed to create player: " + (ex && ex.message ? ex.message : String(ex)));
        }
      };
      setTimeout(() => { if (!player) show("Player did not initialize (possible embed/Referer policy)."); }, 6000);
    })();
  </script>
</body>
</html>
)HTML";

// ──────────────────────────────────────────────────────────────
//  ObjC helper that forwards WK callbacks into GMWebViewManager
// ──────────────────────────────────────────────────────────────
@interface GMBridge : NSObject <WKNavigationDelegate, WKScriptMessageHandler, NSWindowDelegate>
@property(nonatomic,assign) GMWebViewManager *owner;
@end
@implementation GMBridge
- (void)userContentController:(WKUserContentController *)c
      didReceiveScriptMessage:(WKScriptMessage *)m
{ if (_owner) _owner->onInvoke(std::string([m.body UTF8String])); }
- (void)webView:(WKWebView *)v didStartProvisionalNavigation:(WKNavigation *)n
{ if (_owner) _owner->onInvoke("__load_start"); }
- (void)webView:(WKWebView *)v didFinishNavigation:(WKNavigation *)n
{ if (_owner) _owner->onInvoke("__load_end"); }
- (void)windowWillClose:(NSNotification *)note
{ if (_owner) _owner->close(); }
@end

// ──────────────────────────────────────────────────────────────
//  GMWebViewManager   • macOS implementation
// ──────────────────────────────────────────────────────────────
#pragma mark - ctor / singleton

GMWebViewManager &GMWebViewManager::instance()
{
    static GMWebViewManager s;
    return s;
}

GMWebViewManager::~GMWebViewManager()
{
    close();
}

/* -----------------------------------------------------------
 * internal:  create Cocoa window & WKWebView (once)
 * --------------------------------------------------------- */
void GMWebViewManager::ensure()
{
    if (destroying_.load(std::memory_order_acquire))
        return;

    if (running_.load(std::memory_order_acquire))
        return;

    ready_ = false;
    running_ = true;

    std::promise<void> ready_promise;
    auto fut = ready_promise.get_future();

    std::promise<void>* p = &ready_promise;
    runOnMain(^{
        // window
        NSRect f = NSMakeRect(0, 0, 800, 600);
        g.win = [[NSWindow alloc]
            initWithContentRect:f
                      styleMask:(NSWindowStyleMaskTitled
                                 | NSWindowStyleMaskClosable
                                 | NSWindowStyleMaskMiniaturizable
                                 | NSWindowStyleMaskResizable)
                        backing:NSBackingStoreBuffered
                          defer:NO];
        [g.win center];

        // WK config  (inject bridge + GMUI user-script)
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];

        // Media playback parity with iOS/Windows (best effort).
        if (@available(macOS 10.13, *)) {
            cfg.allowsAirPlayForMediaPlayback = YES;
        }

        WKUserContentController *uc  = cfg.userContentController;

        GMBridge *bridge        = [GMBridge new];
        bridge.owner            = this;
        g.nav                   = bridge;
        g.win.delegate          = bridge;
        [uc addScriptMessageHandler:bridge name:@"gm"];

        NSString *src = [NSString stringWithUTF8String:kInjectJS];
        WKUserScript *us = [[WKUserScript alloc] initWithSource:src
                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                               forMainFrameOnly:NO];
        [uc addUserScript:us];

        // WebView
        g.wk = [[WKWebView alloc] initWithFrame:g.win.contentView.bounds
                                   configuration:cfg];
        g.wk.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        g.wk.navigationDelegate = bridge;
        [g.win.contentView addSubview:g.wk];

        // hidden / visible start mode
        if (start_mode_ == WebViewStartMode::Hidden) {
            [g.win orderOut:nil];
            visible_.store(false, std::memory_order_release);
        }
        else
        {
            [g.win makeKeyAndOrderFront:nil];
            visible_.store(true, std::memory_order_release);
        }

        // notify
        ready_.store(true);
        p->set_value();

        // flush queued tasks
        {
            std::lock_guard lk(m_);
            for (auto &f : pending_) f();
            pending_.clear();
        }
    });

    fut.wait();    // caller blocks until window ready
}

/* ----------------------------------------------------------- */
#pragma mark - dispatch helper

void GMWebViewManager::dispatch(const std::function<void()> &fn)
{
    if (!ready_) { std::lock_guard lk(m_); pending_.push_back(fn); return; } 
    runOnMain(^ { fn(); }); 
}

/* ----------------------------------------------------------- */
#pragma mark - lifecycle / visibility

void GMWebViewManager::open(const std::string &url)
{
    ensure();
    dispatch([url]{
        NSURL *u = [NSURL URLWithString:nsstr(url)];
        [g.wk loadRequest:[NSURLRequest requestWithURL:u]];
        if (![g.win isVisible])
            [g.win makeKeyAndOrderFront:nil];
    });
}

void GMWebViewManager::hide()
{
    if (!ready_) return;
    dispatch(^{
        [g.win orderOut:nil];
    });
}

void GMWebViewManager::show()
{
    if (!ready_) return;
    dispatch(^{
        [g.win makeKeyAndOrderFront:nil];
    });
}

void GMWebViewManager::close()
{
    // prevent loops if the delegate calls us, and vice-versa
    if (destroying_.exchange(true)) return;        // already inside

    runOnMain(^{
        if (!ready_) { destroying_ = false; return; }

        /* ---- real cleanup, identical for both paths ---- */
        {
            std::lock_guard<std::mutex> lk(btn_state_mtx_);
            btn_state_.clear();
        }

        // Stop all media playback before cleanup
        if (g.wk) {
            // Use synchronous approach: stop loading first, then stop media
            [g.wk stopLoading];

            NSString* stopMediaJS = @"(function(){"
                "try{"
                    "document.querySelectorAll('video, audio').forEach(function(m){"
                        "m.pause();"
                        "m.src='';"
                        "m.load();"
                    "});"
                    "if(window.YT && window.YT.Player){"
                        "document.querySelectorAll('iframe').forEach(function(f){"
                            "try{"
                                "var p=new YT.Player(f);"
                                "p.stopVideo();"
                                "p.destroy();"
                            "}catch(e){}"
                        "});"
                    "}"
                "}catch(e){}"
            "})();";

            // Execute JS synchronously and wait for completion before proceeding
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [g.wk evaluateJavaScript:stopMediaJS completionHandler:^(id result, NSError *error) {
                dispatch_semaphore_signal(semaphore);
            }];

            // Wait up to 100ms for JavaScript to complete
            dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC));

            // Now navigate to about:blank
            [g.wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];

            // Remove from superview to help with cleanup
            [g.wk removeFromSuperview];

            // Clear delegates and message handlers
            WKUserContentController* uc = g.wk.configuration.userContentController;
            [uc removeScriptMessageHandlerForName:@"gm"];
            g.wk.navigationDelegate = nil;
        }

        g.win.delegate = nil;
        [g.win close];            // harmless if already closing

        g.win = nil; g.wk = nil; g.nav = nil;

        {
            std::lock_guard<std::mutex> lk(m_);
            ready_.store(false, std::memory_order_release);
            running_.store(false, std::memory_order_release);
            loading_.store(false, std::memory_order_release);
            visible_.store(false, std::memory_order_release);
            last_url_.clear();
            last_title_.clear();
            last_params_.clear();
            last_body_.clear();
            next_handle_ = 1;
        }

        destroying_.store(false, std::memory_order_release);
    });
}

/* ----------------------------------------------------------- */
#pragma mark - content helpers  (local / blank / YouTube / offline)

void GMWebViewManager::loadLocal(const std::string &src, bool rawHTML)
{
    ensure();
    dispatch([=]{
        if (rawHTML) {
            std::string uri = "data:text/html;base64," + b64encode(src);
            [g.wk loadRequest:[NSURLRequest requestWithURL:
                               [NSURL URLWithString:nsstr(uri)]]];
        } else {
            std::string u = src.rfind("file://",0)==0 ? src : "file://" + src;
            [g.wk loadFileURL:[NSURL fileURLWithPath:nsstr(u)]
                       allowingReadAccessToURL:[NSURL fileURLWithPath:@"/"]];
        }
    });
}

void GMWebViewManager::loadBlank()
{
    ensure();
    dispatch(^{
        [g.wk loadRequest:[NSURLRequest requestWithURL:
                           [NSURL URLWithString:@"about:blank"]]];
    });
}

void GMWebViewManager::loadYouTube(const std::string &idOrUrl)
{
    ensure();

    const std::string id = yt_extract_id(idOrUrl);
    if (id.empty()) {
        open(idOrUrl);
        return;
    }

    // Load the IFrame API host page as a top-level document with an HTTPS base URL.
    const std::string base = std::string("https://appassets.local/youtube_iframe_api.html?id=") + id;
    dispatch([=]{
        [g.wk loadHTMLString:nsstr(kYT_IFrameApiHostHTML)
                    baseURL:[NSURL URLWithString:nsstr(base)]];
        if (![g.win isVisible]) [g.win makeKeyAndOrderFront:nil];
    });
}

static const char *kNoNetHTML =
    "<!doctype html><html><head><meta charset='utf-8'>"
    "<style>body{display:flex;align-items:center;justify-content:center;height:100vh;"
    "font-family:sans-serif;background:#fafafa;color:#555;text-align:center}h1{font-size:2.5em}</style>"
    "</head><body><div><h1>Offline</h1><p>Please connect to the internet.</p></div></body></html>";

void GMWebViewManager::loadNoInternet()
{
    loadLocal(kNoNetHTML, true);
}

/* ----------------------------------------------------------- */
#pragma mark - window style

void GMWebViewManager::setStartMode(WebViewStartMode m) { start_mode_=m; }

void GMWebViewManager::setBorderless(bool on)
{
    if (!ready_) return;
    dispatch([=]{
        auto style = g.win.styleMask;
        if (on) {
            style &= ~(NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|
                       NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable);
            style |= NSWindowStyleMaskBorderless;
        } else {
            style &= ~NSWindowStyleMaskBorderless;
            style |= (NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|
                      NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable);
        }
        [g.win setStyleMask:style];
    });
}

/* ----------------------------------------------------------- */
#pragma mark - info getters

std::string GMWebViewManager::url() const
{
    std::lock_guard<std::mutex> lk(m_);
    return last_url_;
}

std::string GMWebViewManager::title() const
{
    std::lock_guard<std::mutex> lk(m_);
    return last_title_;
}

std::string GMWebViewManager::body() const
{
    std::lock_guard<std::mutex> lk(m_);
    return last_body_;
}

std::string GMWebViewManager::params() const
{
    std::lock_guard<std::mutex> lk(m_);
    return last_params_;
}

bool GMWebViewManager::isLoading() const { return loading_.load(); }
bool GMWebViewManager::isRunning() const { return running_.load(); }
bool GMWebViewManager::isVisible() const { return visible_.load(); }

/* ----------------------------------------------------------- */
#pragma mark - JS bridge

void GMWebViewManager::evalJS(const std::string &js)
{
    ensure();
    dispatch([=]{
        [g.wk evaluateJavaScript:nsstr(js)
               completionHandler:^(id, NSError* err){
            if (err) NSLog(@"[GMWebView] evalJS error: %@", err);
        }];
    });
}
void GMWebViewManager::evalJS_unsafe(const std::string &js)
{
    if (!ready_) return;
    dispatch([=]{
        [g.wk evaluateJavaScript:nsstr(js) completionHandler:nil];
    });
}

void GMWebViewManager::setJSCallback(const gm::wire::GMFunction &cb)
{
    std::lock_guard<std::mutex> lk(cb_mtx_);
    js_callback_ = cb;
}


void GMWebViewManager::onInvoke(const std::string &raw)
{
    std::string msg;
    if (!extract_first_arg_json(raw, msg)) {
        msg = raw; // worst-case fallback
    }
    /*  The JavaScript that we inject posts strings back via
        window.webkit.messageHandlers.bridge.postMessage(…).

        The format is identical to the Windows implementation, so we can
        reuse the very same parser/logic.
    */
    if (msg == "__injected") {
        ensureButtons();
        return;
    }
    if (msg == "__load_start") {          // page is starting to load
        loading_.store(true);
        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb)
            cb.call(WebViewJavaScriptEvent::OnPageLoadStart);
        return;
    }
    if (msg == "__load_end") {            // page finished
        loading_.store(false);
        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb)
            cb.call(WebViewJavaScriptEvent::OnPageLoadEnd);
        return;
    }

    if (msg.rfind("__url:", 0) == 0) {    // new URL
        std::lock_guard<std::mutex> lk(m_);
        last_url_ = msg.substr(6);
        size_t q = last_url_.find('?');
        last_params_ = (q == std::string::npos) ? "" : last_url_.substr(q + 1);

        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb)
            cb.call(WebViewJavaScriptEvent::OnUrlChange);
        return;
    }
    if (msg.rfind("__title:", 0) == 0) {  // new <title>
        std::lock_guard<std::mutex> lk(m_);
        last_title_ = msg.substr(8);

        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb)
            cb.call(WebViewJavaScriptEvent::OnTitleChange);

        return;
    }
    if (msg.rfind("__body:", 0) == 0) {   // page body snapshot
        std::lock_guard<std::mutex> lk(m_);
        last_body_ = msg.substr(7);
        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb)
            cb.call(WebViewJavaScriptEvent::OnBodyChange);
        return;
    }
    
    if (msg == "__body_dirty") {
        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb) cb.call(WebViewJavaScriptEvent::OnBodyChange);
        return;
    }

    if (msg.rfind("__btn:", 0) == 0) {
        const char* idStr = msg.c_str() + 6;
        const int handle = std::atoi(idStr);

        gm::wire::GMFunction cb;
        {
            std::lock_guard<std::mutex> lk(btn_state_mtx_);
            auto it = btn_state_.find(handle);
            if (it != btn_state_.end()) {
                cb = it->second.cb;
            }
        }
        if (cb) {
            cb.call(handle);
        }
        {
            std::lock_guard<std::mutex> lk(cb_mtx_);
            cb = js_callback_;
        }
        if (cb) {
            cb.call(WebViewJavaScriptEvent::OnButtonPress, handle);
        }
        return;
    }

    if (msg == "__close") {               // page requested close
        requestDestroyFromDom();
        return;
    }

    // Fallback – custom message from page
    gm::wire::GMFunction cb;
    {
        std::lock_guard<std::mutex> lk(cb_mtx_);
        cb = js_callback_;
    }
    if (cb)
        cb.call(WebViewJavaScriptEvent::OnCustomPost, raw);
}

void GMWebViewManager::requestDestroyFromDom()
{
    // bail out if no view or if another destroy is racing
    if (!g.wk || destroying_)
        return;

    // reuse the guarded, re-entrant close()
    close();
}

/* ----------------------------------------------------------- */
#pragma mark - overlay buttons  (identical JS calls)

int GMWebViewManager::buttonCreate(int size, int grav, WebViewButtonAssetType t, const std::string& asset)
{
    ensure();
    int handle = next_handle_++;
    std::string src = compute_button_image(t, asset);

    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto &st = btn_state_[handle];
        st.src = src;
        st.sizeDp = size;
        st.gravity = grav;
        st.ml = st.mt = st.mr = st.mb = 12;
        st.absolute = false;
        st.autoClose = false;
        st.alpha = 1.0;
        st.hidden = false;
    }
    std::ostringstream js;
    js<<"GMUI.addG("<<handle<<","<<std::quoted(src)<<","<<size<<","<<(std::int32_t)grav
      <<",{l:12,t:12,r:12,b:12});";
    evalJS(when_ready(js.str()));
    return handle;
}

void GMWebViewManager::buttonDestroy(int handle)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        btn_state_.erase(handle);
    }
    std::ostringstream js;
    js << "GMUI.rem(" << handle << ");";
    evalJS(js.str());
}

void GMWebViewManager::buttonDestroyAll()
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        btn_state_.clear();
    }
    evalJS("GMUI.remAll();");
}

void GMWebViewManager::buttonSetAlpha(int handle, double a)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) it->second.alpha = a;
        else return;
    }
    std::ostringstream js;
    js << "GMUI.alpha(" << handle << "," << a << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetAutoClose(int handle, bool flag)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) it->second.autoClose = flag;
        else return;
    }
    std::ostringstream js;
    js << "GMUI.autoClose(" << handle << "," << (flag ? "true" : "false") << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetMargins(int handle, int l, int t, int r, int b)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) { it->second.ml=l; it->second.mt=t; it->second.mr=r; it->second.mb=b; }
        else return;
    }
    std::ostringstream js;
    js << "GMUI.margins(" << handle << "," << l << "," << t << "," << r << "," << b << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetSize(int handle, int sizeDp)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) it->second.sizeDp = sizeDp;
        else return;
    }
    std::ostringstream js;
    js << "GMUI.size(" << handle << "," << sizeDp << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetGravity(int handle, int gravity)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) { it->second.absolute = false; it->second.gravity = gravity; }
        else return;
    }
    std::ostringstream js;
    js << "GMUI.gravity(" << handle << "," << (std::int32_t)gravity << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetPosition(int handle, int xDp, int yDp)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) { it->second.absolute = true; it->second.xDp = xDp; it->second.yDp = yDp; }
        else return;
    }
    std::ostringstream js;
    js << "GMUI.pos(" << handle << "," << xDp << "," << yDp << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonShow(int handle)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) it->second.hidden = false;
        else return;
    }
    std::ostringstream js;
    js << "GMUI.show(" << handle << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonHide(int handle)
{
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) it->second.hidden = true;
        else return;
    }
    std::ostringstream js;
    js << "GMUI.hide(" << handle << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetAsset(int handle, WebViewButtonAssetType t, const std::string& asset)
{
    std::string src = compute_button_image(t, asset);

    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        auto it = btn_state_.find(handle);
        if (it != btn_state_.end()) it->second.src = src;
        else return;
    }

    std::ostringstream js;
    js << "GMUI.asset(" << handle << "," << std::quoted(src) << ");";
    evalJS(when_ready_el(handle, js.str()));
}

void GMWebViewManager::buttonSetCallback(int handle, gm::wire::GMFunction cb)
{
    std::lock_guard<std::mutex> lk(btn_state_mtx_);
    auto it = btn_state_.find(handle);
    if (it != btn_state_.end()) it->second.cb = cb;
}

void GMWebViewManager::buttonClearCallback(int handle)
{
    std::lock_guard<std::mutex> lk(btn_state_mtx_);
    auto it = btn_state_.find(handle);
    if (it != btn_state_.end()) it->second.cb = nullptr;
}

void GMWebViewManager::ensureButtons()
{
    std::unordered_map<int, ButtonState> snapshot;
    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        snapshot = btn_state_;
    }

    // If no state, remove any leftover DOM buttons.
    // (Optional; you may want to keep them if you consider DOM the source of truth.)
    std::ostringstream js;
    js << "try{ if(!window.GMUI) return;";

    // Build a JS set of valid IDs
    js << "var keep={};";
    for (auto& kv : snapshot)
        js << "keep['gm_btn_" << kv.first << "']=1;";

    // 1) Remove unknown DOM buttons (prevents accumulation across navigations)
    js << "document.querySelectorAll('[id^=gm_btn_]').forEach(function(e){"
          "if(!keep[e.id]) e.remove();"
          "});";

    // 2) Upsert each desired button
    for (auto& kv : snapshot) {
        int handle = kv.first;
        const auto& st = kv.second;

        js << "{"
              "var id="
           << handle
           << ";"
              "var el=document.getElementById('gm_btn_'+id);"
              "if(!el){"
              "GMUI.addG(id,"
           << std::quoted(st.src) << "," << st.sizeDp << "," << (int)st.gravity << ",{l:" << st.ml << ",t:" << st.mt
           << ",r:" << st.mr << ",b:" << st.mb
           << "});"
              "}"
              // Apply desired state (idempotent)
              "GMUI.autoClose(id,"
           << (st.autoClose ? "true" : "false")
           << ");"
              "GMUI.alpha(id,"
           << st.alpha
           << ");"
              "GMUI.asset(id,"
           << std::quoted(st.src)
           << ");"
              "GMUI.size(id,"
           << st.sizeDp << ");";

        if (st.absolute) {
            js << "GMUI.pos(id," << st.xDp << "," << st.yDp << ");";
        } else {
            js << "GMUI.margins(id," << st.ml << "," << st.mt << "," << st.mr << "," << st.mb << ");"
               << "GMUI.gravity(id," << (int)st.gravity << ");";
        }

        js << (st.hidden ? "GMUI.hide(id);" : "GMUI.show(id);");
        js << "}";
    }

    js << "}catch(e){}";

    // Wait until GMUI/body exist
    evalJS(when_ready(js.str()));
}

