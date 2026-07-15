package ${YYAndroidPackageName}; 
 
import android.annotation.SuppressLint; 
import android.app.Activity; 
import android.content.*; 
import android.graphics.*; 
import android.graphics.drawable.Drawable; 
import android.graphics.drawable.BitmapDrawable; 
import android.net.ConnectivityManager; 
import android.net.NetworkCapabilities; 
import android.net.Uri; 
import android.os.*; 
import android.util.Base64; 
import android.util.Log; 
import android.view.*; 
import android.webkit.*; 
import android.widget.FrameLayout; 
import android.widget.ImageView; 
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout; 
 
import java.io.ByteArrayOutputStream; 
import java.io.IOException; 
import java.io.InputStream; 
import java.util.HashMap; 
import java.util.Map; 
import java.util.concurrent.CountDownLatch; 
import java.util.concurrent.atomic.AtomicInteger; 
import java.util.regex.Matcher; 
import java.util.regex.Pattern;

import ${YYAndroidPackageName}.GMExtWire.GMFunction;
 
public final class GMWebViewManager { 
 
    // ─────────────────────────────────────────────────────────── 
    // Singleton boilerplate 
    // ─────────────────────────────────────────────────────────── 
 
    private static final String TAG = "yoyo"; 
    private static GMWebViewManager sInstance; 
 
    public static GMWebViewManager get() { 
        if (sInstance == null) { 
            sInstance = new GMWebViewManager(); 
        } 
        return sInstance; 
    } 
 
    private GMWebViewManager() { 
    } 
 
    // ─────────────────────────────────────────────────────────── 
    // JavaScript Code Injection 
    // ─────────────────────────────────────────────────────────── 

    // Same behavior as desktop/mac injection, but posts via Android JS interface.
    private static final String INJECT_JS = "(function(){"
        + "function post(){"
        + "  try {"
        + "    var args = Array.prototype.slice.call(arguments);"
        + "    if (window.GMBridge && GMBridge.postMessage) {"
        + "      GMBridge.postMessage(JSON.stringify(args));"
        + "    }"
        + "  } catch(e) { }"
        + "}"
        + "window.gm_post = post;"
        + "post('__injected');"
        + "post('__load_start');"

        // DOMContentLoaded -> load_end + body snapshot
        + "document.addEventListener('DOMContentLoaded', function(){"
        + "  post('__load_end');"
        + "  try{ var html = document.body ? document.body.innerHTML : ''; post('__body:' + html); }catch(e){}"
        + "});"

        // URL/title tracking + gmwebview:// support
        + "function sendUrlTitle(){"
        + "  try{"
        + "    var href = String(location.href || '');"
        + "    if (href !== window.__gm_href) {"
        + "      window.__gm_href = href;"
        + "      post('__url:' + href);"
        + "      post('__title:' + (document.title || ''));"
        + "      if (href.indexOf('gmwebview://') === 0) {"
        + "        post('__gm:' + decodeURIComponent(href.substr(12)));"
        + "      }"
        + "    } else {"
        + "      var t = String(document.title || '');"
        + "      if (t !== window.__gm_title) {"
        + "        window.__gm_title = t;"
        + "        post('__title:' + t);"
        + "      }"
        + "    }"
        + "  }catch(e){}"
        + "}"

        // Hook History API for SPAs
        + "(function(){"
        + "  try{"
        + "    var _ps = history.pushState;"
        + "    var _rs = history.replaceState;"
        + "    history.pushState = function(){ var r = _ps.apply(this, arguments); setTimeout(sendUrlTitle,0); return r; };"
        + "    history.replaceState = function(){ var r = _rs.apply(this, arguments); setTimeout(sendUrlTitle,0); return r; };"
        + "    window.addEventListener('popstate', function(){ setTimeout(sendUrlTitle,0); }, true);"
        + "    window.addEventListener('hashchange', function(){ setTimeout(sendUrlTitle,0); }, true);"
        + "  }catch(e){}"
        + "})();"

        // initial + slow fallback poll (reduced spam)
        + "sendUrlTitle();"
        + "setInterval(sendUrlTitle, 1000);"

        // Body change detection (debounced) -> __body_dirty
        + "(function(){"
        + "  var DEBOUNCE_MS = 350;"
        + "  var timer = 0;"
        + "  var pending = false;"
        + "  function schedule(){"
        + "    if (pending) return;"
        + "    pending = true;"
        + "    if (timer) clearTimeout(timer);"
        + "    timer = setTimeout(flush, DEBOUNCE_MS);"
        + "  }"
        + "  function flush(){"
        + "    pending = false; timer = 0;"
        + "    post('__body_dirty');"
        + "  }"
        + "  function boot(){"
        + "    var root = document.body || document.documentElement;"
        + "    if (!root) return;"
        + "    try{"
        + "      var obs = new MutationObserver(schedule);"
        + "      obs.observe(root, {subtree:true, childList:true, characterData:true});"
        + "      window.__gm_bodyObs = obs;"
        + "    }catch(e){}"
        + "  }"
        + "  if (document.readyState === 'loading') {"
        + "    document.addEventListener('DOMContentLoaded', boot, {once:true});"
        + "  } else { boot(); }"
        + "})();"

        + "})();";



    // ─────────────────────────────────────────────────────────── 
    // Youtube API 
    // ─────────────────────────────────────────────────────────── 

    // Fake HTTPS origin we serve from memory (to satisfy Referer/client identity)
    private static final String APPASSETS_HOST = "appassets.local";
    private static final String APPASSETS_ORIGIN = "https://" + APPASSETS_HOST;
    private static final String YT_HOST_PAGE_PATH = "/youtube_iframe_api.html";

    private static String ytIFrameApiHostHtml()
    {
        // Reads ?id=... and boots the official IFrame API
        return "<!doctype html><html style='width:100%;height:100%'><head>" +
                "<meta charset='utf-8'>" +
                "<meta name='referrer' content='strict-origin-when-cross-origin'>" +
                "<meta name='viewport' content='width=device-width,height=device-height,initial-scale=1'>" +
                "<style>html,body{margin:0;width:100%;height:100%;overflow:hidden;background:#000}" +
                "#player{width:100%;height:100%}</style>" +
                "</head><body><div id='player'></div>" +
                "<script>" +
                "const p=new URLSearchParams(location.search);" +
                "const id=(p.get('id')||'').trim();" +
                "var tag=document.createElement('script');" +
                "tag.src='https://www.youtube.com/iframe_api';" +
                "document.head.appendChild(tag);" +
                "var player;" +
                "window.onYouTubeIframeAPIReady=function(){" +
                " if(!id) return;" +
                " player=new YT.Player('player',{" +
                "  width:'100%',height:'100%',videoId:id," +
                "  playerVars:{autoplay:1,playsinline:1,rel:0}," +
                "  events:{onReady:function(e){try{e.target.playVideo()}catch(_){} }}" +
                " });" +
                "};" +
                "</script></body></html>";
    }

    // ─────────────────────────────────────────────────────────── 
    // Fields 
    // ─────────────────────────────────────────────────────────── 
 
    private Activity activity; 
    private SwipeRefreshLayout swipe; 
    private android.webkit.WebView web; 
    private boolean allowSwipe = false;

    private boolean isLoading = false; 
    private boolean isRunning = false; 
    private boolean isVisible = false; 
    private int startMode = WEBVIEW_START_MODE_VISIBLE;

    private boolean debugEnabled = false; 
 
    // Cached data 
    private String lastUrl = ""; 
    private String lastTitle = ""; 
    private String lastBody = ""; 
    private String lastParams = ""; 
  
    private volatile GMFunction callback; 
 
    // Special schemes we open in external apps 
    private static final Pattern EXTERNAL_SCHEME = Pattern.compile("^(whatsapp|itms-apps|market|mailto|tel):", 
            Pattern.CASE_INSENSITIVE); 
 
    // Builtin no internet page 
    private static final String DEFAULT_NO_NET_HTML = "<!doctype html><html><head><meta charset='utf-8'/>" + 
            "<style>body{display:flex;align-items:center;justify-content:center;" + 
            "font-family:sans-serif;text-align:center;background:#fafafa;color:#444;}" + 
            "h1{font-size:2.4em;margin:0}p{opacity:.6}</style></head>" + 
            "<body><div><h1>Offline</h1><p>You don't appear to be connected " + 
            "to the internet.</p></div></body></html>"; 
 
    // ─────────────────────────────────────────────────────────── 
    // Initialisation 
    // ─────────────────────────────────────────────────────────── 
 
    /** 
     * Must be called once with the current {@link Activity}. 
     *  
     * @param act         current foreground Activity 
     * @param enableDebug set true to enable WebView remote debugging (Chrome) 
     */ 
    public void init(Activity act, boolean enableDebug) { 
        this.activity = act; 
        this.debugEnabled = enableDebug; 
    } 
 
    // ─────────────────────────────────────────────────────────── 
    // Public control methods 
    // ─────────────────────────────────────────────────────────── 
 
    public void setJSCallback(GMFunction cb) { 
        this.callback = cb; 
    } 
 
    /** Show / unhide. */ 
    public void show() {
        runOnUiThread(() -> {
            if (swipe != null) {
                isVisible = true;
                swipe.setVisibility(View.VISIBLE);
            }
        });
    }

    public void hide() {
        runOnUiThread(() -> {
            if (swipe != null) {
                isVisible = false;
                swipe.setVisibility(View.GONE);
            }
        });
    }
 
    /** Remove WebView entirely. */ 
    public void close() { 
        runOnUiThread(() -> { 
            buttonDestroyAll(); 
            if (web == null) 
                return; 
            ViewGroup parent = (ViewGroup) swipe.getParent(); 
            if (parent != null) 
                parent.removeView(swipe); 
            web.removeJavascriptInterface("GMBridge"); 
            web.destroy(); 
            web = null; 
            swipe = null; 
            isRunning = false;
            isVisible = false;

            lastUrl = ""; 
            lastTitle = ""; 
            lastBody = ""; 
            lastParams = ""; 

            Log.d(TAG, "WebView closed"); 
        }); 
    } 
 
    /** Enable or disable swipe‑to‑refresh. */ 
    public void allowSwipeRefresh(boolean allow) { 
        allowSwipe = allow; 
        runOnUiThread(() -> { 
            if (swipe != null) 
                swipe.setEnabled(allowSwipe); 
        }); 
    } 
 
    // ─────────────── load helpers ─────────────── 
 
    /** Open and navigate to a remote URL. */ 
    public void openUrl(String url) { 
        ensureCreated(); 
        runOnUiThread(() -> web.loadUrl(url)); 
    } 
 
    /** Load raw HTML (base64 encoded internally). */ 
    public void loadHtml(String html) { 
        ensureCreated(); 
        runOnUiThread(() -> web.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null)); 
    } 
 
    /** Load a local asset or file:// URL. */ 
    public void loadLocal(String path) { 
        // If asset file name only, prepend android_asset 
        if (!path.startsWith("file:")) 
            path = "file:///android_asset/" + path; 
        String finalPath = path; 
        ensureCreated(); 
        runOnUiThread(() -> web.loadUrl(finalPath)); 
    } 
 
    /** Show blank page. */ 
    public void loadBlank() { 
        ensureCreated(); 
        runOnUiThread(() -> web.loadUrl("about:blank")); 
    } 
 
    /** Show “no internet” page (asset/no-internet.html). */ 
    public void loadNoInternet() { 
        if (assetExists("no-internet.html")) { 
            loadLocal("no-internet.html"); 
        } else { 
            loadHtml(DEFAULT_NO_NET_HTML); 
        } 
    }
 
    /** Show YouTube embed given a full URL or just the video ID. */ 
    public void loadYouTube(String idOrUrl) {
        String id = idOrUrl;

        Matcher m = Pattern.compile(
                "[?&]v=([^&]+)|youtu\\.be/([^?&/]+)|/embed/([^?&/]+)",
                Pattern.CASE_INSENSITIVE
        ).matcher(idOrUrl);

        if (m.find()) {
            id = (m.group(1) != null) ? m.group(1) : ((m.group(2) != null) ? m.group(2) : m.group(3));
        }

        final String videoId = id;
        ensureCreated();
        runOnUiThread(() -> web.loadUrl(APPASSETS_ORIGIN + YT_HOST_PAGE_PATH + "?id=" + Uri.encode(videoId)));
    }

    public void openExternal(String url)
    {
        if (url == null) return;
        final String u = url.trim();
        if (u.isEmpty()) return;

        runOnUiThread(() -> {
            try {
                Uri uri = Uri.parse(u);

                // If no scheme, assume https (matches typical desktop behavior)
                if (uri.getScheme() == null) {
                    uri = Uri.parse("https://" + u);
                }

                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                intent.addCategory(Intent.CATEGORY_BROWSABLE);

                // If you might call from a non-Activity context, keep NEW_TASK.
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                activity.startActivity(intent);
            } catch (android.content.ActivityNotFoundException ignored) {
                // No app can handle it
            } catch (Exception ignored) {}
        });
    }

    public static final int WEBVIEW_START_MODE_HIDDEN = 0;
    public static final int WEBVIEW_START_MODE_VISIBLE = 1;

    public void setStartMode(int mode) 
    {
        startMode = mode;
    }

    // ─────────────── JavaScript bridge ─────────────── 
 
    /** Evaluate JS (async, on UI thread). */ 
    public void evalJS(String js) { 
        ensureCreated(); 
        runOnUiThread(() -> web.evaluateJavascript(js, null)); 
    } 
 
    // ─────────────── getters ─────────────── 
 
    public String getUrl() { 
        return lastUrl; 
    } 
 
    public String getTitle() { 
        return lastTitle; 
    } 
 
    public boolean isLoading() { 
        return isLoading; 
    } 
 
    public boolean isRunning() { 
        return isRunning;
    } 

    public boolean isVisible() { 
        return isVisible; 
    } 

    public String getBody() { 
        return lastBody; 
    } 
 
    public String getParams() { 
        return lastParams; 
    } 
 
    // ─────────────── buttons ─────────────── 
 
    public static final int BUTTON_ASSET_DEFAULT_ICON = 0;
    public static final int BUTTON_ASSET_ASSET_PATH   = 1;
    public static final int BUTTON_ASSET_FILE_PATH    = 2;
    public static final int BUTTON_ASSET_BASE64_DATA  = 3;
    public static final int BUTTON_ASSET_RAW_HTML     = 4; // not supported w/ ImageView; will fallback
    
    private final AtomicInteger nextHandle = new AtomicInteger(1); 
 
    private boolean applyButtonImage(ImageView iv, int sizePx, int assetType, String asset)
    {
        try {
            Bitmap bmp = null;

            switch (assetType) {
                case BUTTON_ASSET_DEFAULT_ICON:
                    break;

                case BUTTON_ASSET_ASSET_PATH:
                    if (asset != null && !asset.isEmpty()) {
                        try (InputStream is = activity.getAssets().open(asset)) {
                            bmp = BitmapFactory.decodeStream(is);
                        }
                    }
                    break;

                case BUTTON_ASSET_FILE_PATH:
                    if (asset != null && !asset.isEmpty()) {
                        bmp = BitmapFactory.decodeFile(asset);
                    }
                    break;

                case BUTTON_ASSET_BASE64_DATA:
                    if (asset != null && !asset.isEmpty()) {
                        // Accept either raw base64 OR a "data:image/png;base64,..." string
                        String b64 = asset;
                        int comma = b64.indexOf(',');
                        if (comma >= 0) b64 = b64.substring(comma + 1);

                        byte[] data = Base64.decode(b64, Base64.DEFAULT);
                        bmp = BitmapFactory.decodeByteArray(data, 0, data.length);
                    }
                    break;

                case BUTTON_ASSET_RAW_HTML:
                    // Minimal-change policy: not supported without swapping to WebView overlay
                    bmp = null;
                    break;

                default:
                    bmp = null;
                    break;
            }

            if (bmp != null) {
                iv.setImageBitmap(bmp);
                return true;
            }
        } catch (Exception ignored) {}

        iv.setImageDrawable(createDefaultButtonDrawable(sizePx));
        return false;
    }


    /** 
     * Add or replace a button overlay. 
     * 
     * @param assetPath asset file (e.g. "close.png") or null for default icon 
     * @param sizeDp    width/height in dp 
     * @param gravity   Android Gravity flags (e.g. Gravity.TOP | Gravity.END) 
     */ 
    public int buttonCreate(int sizeDp, int gravityInt, int assetType, String assetPath) { 
        ensureCreated(); 
 
        final int handle = nextHandle.getAndIncrement(); 
        runOnUiThread(() -> { 
            buttonDestroy(handle); 
 
            WVButton info = new WVButton(); 
            info.autoClose = false; 
            info.absolute = false; 
            info.sizePx = dp(sizeDp); 
            info.gravity = gravityInt; 
            info.marginL = info.marginT = info.marginR = info.marginB = dp(12); // default margin 
 
            ImageView iv = new ImageView(activity); 
            FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(info.sizePx, info.sizePx, info.gravity); 
            lp.setMargins(info.marginL, info.marginT, info.marginR, info.marginB); 
            iv.setLayoutParams(lp); 
            iv.setScaleType(ImageView.ScaleType.FIT_CENTER); 
            iv.setAlpha(1f); 
 
            applyButtonImage(iv, dp(sizeDp), assetType, assetPath);
 
            iv.setOnClickListener(v -> { 
                WVButton b = buttons.get(handle); 
                if (b != null && b.autoClose) close();
                else if (b != null && b.callback != null) b.callback.call();
                else if (callback != null) callback.call("__btn:" + handle);
            }); 
 
            ViewGroup root = activity.findViewById(android.R.id.content); 
            root.addView(iv); 
            info.view = iv; 
            buttons.put(handle, info); 
        }); 
 
        return handle; 
    } 
 
    public void buttonSetCallback(int handle, final GMFunction cb) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); 
            if (b != null) 
                b.callback = cb; 
        }); 
    } 
 
    public void buttonDestroy(int handle) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.remove(handle); 
            if (b != null && b.view != null) { 
                ViewGroup p = (ViewGroup)b.view.getParent(); 
                if (p != null) p.removeView(b.view); 
            } 
        }); 
    } 
 
    public void buttonDestroyAll() { 
        runOnUiThread(() -> { 
            if (buttons.isEmpty()) return;
            ViewGroup root = activity.findViewById(android.R.id.content); 
            for (WVButton b : buttons.values()) { 
                if (b != null && b.view != null) { 
                    if (root != null) root.removeView(b.view); 
                    // help GC on older devices 
                    b.view.setImageDrawable(null); 
                    b.view = null;
                    b.callback = null;
                } 
            } 
            buttons.clear();
            nextHandle.set(1);
        }); 
    } 
 
    public void buttonSetAlpha(int handle, double alpha) { 
        runOnUiThread(() -> { WVButton b = buttons.get(handle); if (b!=null) b.view.setAlpha((float)alpha); }); 
    } 
 
    public void buttonSetAutoClose(int handle, boolean flag) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); 
            if (b != null) { 
                b.autoClose = flag; 
            } 
        }); 
    } 
 
    public void buttonSetMargins(int handle, int l, int t, int r, int btm) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); if (b==null) return; 
            b.marginL = dp(l); b.marginT = dp(t); b.marginR = dp(r); b.marginB = dp(btm); 
            FrameLayout.LayoutParams lp = (FrameLayout.LayoutParams)b.view.getLayoutParams(); 
            lp.setMargins(b.marginL,b.marginT,b.marginR,b.marginB); 
            b.view.setLayoutParams(lp); 
        }); 
    } 
 
    public void buttonSetSize(int handle, int sizeDp) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); if (b==null) return; 
            b.sizePx = dp(sizeDp); 
            FrameLayout.LayoutParams lp = (FrameLayout.LayoutParams)b.view.getLayoutParams(); 
            lp.width = lp.height = b.sizePx; 
            b.view.setLayoutParams(lp); 
            // regenerate default icon if using fallback 
        }); 
    } 
 
    public void buttonSetGravity(int handle, int gravityInt) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); if (b==null) return; 
            b.absolute = false; 
            b.gravity = gravityInt; 
            FrameLayout.LayoutParams lp = (FrameLayout.LayoutParams)b.view.getLayoutParams(); 
            lp.gravity = b.gravity; 
            lp.leftMargin = b.marginL; lp.topMargin = b.marginT; 
            lp.rightMargin = b.marginR; lp.bottomMargin = b.marginB; 
            b.view.setLayoutParams(lp); 
        }); 
    } 
 
    public void buttonSetPosition(int handle, int xDp, int yDp) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); if (b==null) return; 
            b.absolute = true; 
            b.xPx = dp(xDp); b.yPx = dp(yDp); 
            FrameLayout.LayoutParams lp = (FrameLayout.LayoutParams)b.view.getLayoutParams(); 
            lp.gravity = Gravity.TOP | Gravity.START; 
            lp.leftMargin = (int)b.xPx; 
            lp.topMargin  = (int)b.yPx; 
            // keep width/height; ignore right/bottom 
            b.view.setLayoutParams(lp); 
        }); 
    } 
 
    public void buttonShow(int handle) { 
        runOnUiThread(() -> { WVButton b = buttons.get(handle); if (b!=null) b.view.setVisibility(View.VISIBLE); }); 
    } 
     
    public void buttonHide(int handle) { 
        runOnUiThread(() -> { WVButton b = buttons.get(handle); if (b!=null) b.view.setVisibility(View.GONE); }); 
    } 
 
    public void buttonSetAsset(int handle, int assetType, String assetPath) { 
        runOnUiThread(() -> { 
            WVButton b = buttons.get(handle); if (b==null) return;
            applyButtonImage(b.view, b.sizePx, assetType, assetPath);
        }); 
    } 
 
    // ─────────────────────────────────────────────────────────── 
    // Screenshot capture (returns PNG byte[]) 
    // ─────────────────────────────────────────────────────────── 
 
    public byte[] capturePng() { 
        if (web == null) 
            return null; 
 
        final CountDownLatch latch = new CountDownLatch(1); 
        final Bitmap[] bmp = new Bitmap[1]; 
 
        runOnUiThread(() -> { 
            try { 
                int w = web.getWidth(); 
                int h = web.getHeight(); 
                if (w == 0 || h == 0) { 
                    latch.countDown(); 
                    return; 
                } 
                bmp[0] = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888); 
                Canvas c = new Canvas(bmp[0]); 
                web.draw(c); 
            } catch (Throwable t) { 
                Log.e(TAG, "capture failed", t); 
            } 
            latch.countDown(); 
        }); 
 
        try { 
            latch.await(); 
        } catch (InterruptedException ignored) { 
        } 
 
        if (bmp[0] == null) 
            return null; 
        ByteArrayOutputStream out = new ByteArrayOutputStream(); 
        bmp[0].compress(Bitmap.CompressFormat.PNG, 100, out); 
        return out.toByteArray(); 
    } 
 
    // ─────────────────────────────────────────────────────────── 
    // Internal helpers 
    // ─────────────────────────────────────────────────────────── 
 
    private static class WVButton { 
        ImageView view; 
        GMFunction callback; 
        boolean autoClose; 
        boolean absolute;          // true if using x/y 
        int sizePx; 
        int gravity; 
        int marginL, marginT, marginR, marginB; 
        float xPx, yPx;            // absolute offsets (top-left) 
    } 
 
    private final Map<Integer, WVButton> buttons = new HashMap<>(); 
 
    private final WebViewClient browserClient = new WebViewClient() { 
 
        @Override  
        public void onPageStarted(android.webkit.WebView v, String url, Bitmap favicon) { 
            isLoading = true;
            if (swipe != null) swipe.setRefreshing(true);

            // Keep parity: desktop posts __load_start itself too, but we still cache URL here.
            lastUrl = url != null ? url : "";
            lastTitle = "";
            lastParams = computeParams(lastUrl);

            injectDomGrabbers();
        } 
 
        @Override
        public void onPageFinished(android.webkit.WebView v, String url) {
            isLoading = false;
            if (swipe != null) swipe.setRefreshing(false);

            // Re-inject (some pages replace JS world / iframes / etc.)
            injectDomGrabbers();
        }
 
        @Override  
        public void onReceivedError(android.webkit.WebView v, WebResourceRequest req, WebResourceError err) { 
            Log.e(TAG,"Web error: " + err.getErrorCode() + " " + err.getDescription()); 
            if (!hasInternet()) 
                loadNoInternet(); 
        } 
 
        @Override  
        public boolean shouldOverrideUrlLoading(android.webkit.WebView v, WebResourceRequest req) { 
            String u=req.getUrl().toString(); 
 
            // gmwebview:// → send to GameMaker via callback 
            if (u.startsWith("gmwebview://")) { 
                if (callback!=null) callback.call(Uri.decode(u.substring(12))); 
                return true; 
            } 
             
            if (EXTERNAL_SCHEME.matcher(u).find()) { 
                handleExternal(u); 
                return true; 
            } 
             
            return false; 
        }

        @Override
        public WebResourceResponse shouldInterceptRequest(android.webkit.WebView view, WebResourceRequest request) {
            Uri u = request.getUrl();
            if (u != null && APPASSETS_HOST.equalsIgnoreCase(u.getHost())) {
                String path = u.getPath();
                if (YT_HOST_PAGE_PATH.equals(path)) {
                    byte[] bytes = ytIFrameApiHostHtml().getBytes(java.nio.charset.StandardCharsets.UTF_8);
                    WebResourceResponse resp = new WebResourceResponse("text/html", "utf-8",
                            new java.io.ByteArrayInputStream(bytes));
                    // Optional headers
                    resp.setResponseHeaders(new java.util.HashMap<String, String>() {{
                        put("Cache-Control", "no-store");
                    }});
                    return resp;
                }
            }
            return null; // let WebView handle everything else normally
        }
    }; 
 
    private void ensureCreated() { 
        if (web != null) 
            return; 
        activity.runOnUiThread(() -> { 
            if (web != null) 
                return; 
 
            swipe = new SwipeRefreshLayout(activity); 
            swipe.setLayoutParams(new FrameLayout.LayoutParams( 
                    ViewGroup.LayoutParams.MATCH_PARENT, 
                    ViewGroup.LayoutParams.MATCH_PARENT)); 
 
            web = new android.webkit.WebView(activity); 
            web.setLayoutParams(new FrameLayout.LayoutParams( 
                    ViewGroup.LayoutParams.MATCH_PARENT, 
                    ViewGroup.LayoutParams.MATCH_PARENT)); 
            web.setBackgroundColor(Color.WHITE); // or TRANSPARENT if you prefer 
 
            isRunning = true;
            isVisible = (startMode == WEBVIEW_START_MODE_VISIBLE);
            swipe.setVisibility(isVisible ? View.VISIBLE : View.GONE);

            swipe.addView(web);
            activity.addContentView(swipe, swipe.getLayoutParams()); 
 
            if (Build.VERSION.SDK_INT >= 19 && debugEnabled) { 
                android.webkit.WebView.setWebContentsDebuggingEnabled(true); 
            } 
 
            WebSettings s = web.getSettings(); 
            s.setJavaScriptEnabled(true); 
            s.setDomStorageEnabled(true); 
            s.setAllowFileAccess(true); 
            s.setMediaPlaybackRequiresUserGesture(false); 
 
            web.addJavascriptInterface(new JSBridge(), "GMBridge"); 
            swipe.setOnRefreshListener(() -> web.reload()); 
            swipe.setEnabled(allowSwipe); 
            web.setWebViewClient(browserClient); 
            web.setWebChromeClient(new WebChromeClient()); 
 
            Log.d(TAG, "WebView created"); 
        }); 
    } 
 
    /** Inject lightweight JS that grabs body HTML & passes to Java. */ 
    private void injectDomGrabbers() { 
        if (web == null) return;
        // Wrap so injection is idempotent
        final String js = "(() => { try {"
                + "if (window.__gm_injected) return;"
                + "window.__gm_injected = true;"
                + INJECT_JS
                + "} catch(e){} })();";

        web.evaluateJavascript(js, null);
    } 
 
    private class JSBridge {
        @JavascriptInterface
        public void postMessage(String json) {
            onInvoke(json);
        }

        // You can keep postBody, but it becomes redundant once __body: exists.
        @JavascriptInterface
        public void postBody(String html) {
            lastBody = (html != null) ? html : "";
        }
    }
 
    private static String extractFirstArgJson(String raw) {
        if (raw == null) return "";
        raw = raw.trim();
        if (raw.isEmpty()) return "";

        // Most common: ["__url:..."] or ["custom"]
        if (raw.charAt(0) == '[') {
            try {
                org.json.JSONArray a = new org.json.JSONArray(raw);
                if (a.length() > 0) return a.optString(0, raw);
            } catch (Exception ignored) {}
        }

        // Sometimes it could be a JSON string: "__url:..."
        if (raw.charAt(0) == '"') {
            try {
                return org.json.JSONObject.wrap(raw).toString(); // not great
            } catch (Exception ignored) {}
            // fallback: try naive unquote
            if (raw.length() >= 2 && raw.endsWith("\"")) {
                return raw.substring(1, raw.length() - 1);
            }
        }

        return raw;
    }

    private static String computeParams(String href) {
        if (href == null) return "";
        int q = href.indexOf('?');
        int h = href.indexOf('#');

        String query = "";
        if (q >= 0) {
            query = href.substring(q + 1, (h >= 0 ? h : href.length()));
        }

        String hash = "";
        if (h >= 0 && h + 1 < href.length()) {
            hash = href.substring(h + 1);
        }

        if (!hash.isEmpty()) {
            return query + "#" + hash;
        }
        return query;
    }

    public static final int ON_URL_CHANGE = 0;
    public static final int ON_BOBY_CHANGE = 1;
    public static final int ON_TITLE_CHANGE = 2;
    public static final int ON_BUTTON_PRESS = 3;
    public static final int ON_PAGE_LOAD_START = 4;
    public static final int ON_PAGE_LOAD_END = 5;
    public static final int ON_CUSTOM_POST = 6;

    private void onInvoke(String rawJson)
    {
        final String msg = extractFirstArgJson(rawJson);

        if ("__injected".equals(msg)) {
            // Nothing required for native overlay buttons, but you could ensure state here if you ever swap to DOM buttons.
            return;
        }
        if ("__load_start".equals(msg)) {
            isLoading = true;
            callback.call(ON_PAGE_LOAD_START);
            return;
        }
        if ("__load_end".equals(msg)) {
            isLoading = false;
            callback.call(ON_PAGE_LOAD_END);
            return;
        }

        if (msg.startsWith("__url:")) {
            lastUrl = msg.substring(6);
            lastParams = computeParams(lastUrl);
            // Forward parity event (desktop doesn’t prefix this; it emits a callback event)
            if (callback != null) callback.call(ON_URL_CHANGE);
            return;
        }

        if (msg.startsWith("__title:")) {
            lastTitle = msg.substring(8);
            if (callback != null) callback.call(ON_TITLE_CHANGE);
            return;
        }

        if (msg.startsWith("__body:")) {
            lastBody = msg.substring(7);
            if (callback != null) callback.call(ON_BOBY_CHANGE);
            return;
        }

        if ("__body_dirty".equals(msg)) {
            // Match mac: OnBodyChange event without pushing giant body payloads.
            if (callback != null) callback.call(ON_BOBY_CHANGE);
            return;
        }

        if (msg.startsWith("__btn:")) {
            int handle = -1;
            try {
                handle = Integer.parseInt(msg.substring(6));
            } catch (Exception ignored) {}

            if (handle <= 0) return;

            GMFunction btnCb = null;
            WVButton b = buttons.get(handle);
            if (b != null) btnCb = b.callback;

            if (btnCb != null) {
                // parity with C++: pass the id as string
                btnCb.call(handle);
                return;
            }

            if (callback != null) {
                callback.call(ON_BUTTON_PRESS, handle);
            }
            return;
        }

        if ("__close".equals(msg)) {
            close();
            return;
        }

        if (msg.startsWith("__gm:")) {
            // This is what desktop does internally; you can choose to forward either "__gm:..." or just payload.
            // Keeping parity with desktop custom-post handling: forward as-is.
            if (callback != null) callback.call(msg);
            return;
        }

        // Fallback: custom message
        if (callback != null) callback.call(ON_CUSTOM_POST, rawJson);
    }


    private boolean handleExternal(String url) { 
        try { 
            Intent i = new Intent(Intent.ACTION_VIEW, Uri.parse(url)); 
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
            activity.startActivity(i); 
            return true; 
        } catch (ActivityNotFoundException e) { 
            Log.w(TAG, "No handler for " + url); 
            return false; 
        } 
    } 
 
    private boolean hasInternet() { 
        ConnectivityManager cm = (ConnectivityManager) activity.getSystemService(Context.CONNECTIVITY_SERVICE); 
        if (cm == null) 
            return false; 
        NetworkCapabilities nc = cm.getNetworkCapabilities(cm.getActiveNetwork()); 
        return nc != null && 
                (nc.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) || 
                        nc.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) || 
                        nc.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)); 
    } 
 
    private boolean assetExists(String name) { 
        try (InputStream ignored = activity.getAssets().open(name)) { 
            return true; 
        } catch (IOException e) { 
            return false; 
        } 
    } 
 
    private void runOnUiThread(Runnable r) { 
        if (Looper.myLooper() == Looper.getMainLooper()) { 
            r.run(); 
        } else if (activity != null) { 
            activity.runOnUiThread(r); 
        } 
    } 
 
    // Convert dp units to pixels 
    private int dp(int value) { 
        return Math.round(value * activity.getResources() 
                .getDisplayMetrics().density); 
    } 
 
    // Fallback icon (a circular dark background with an “X”) 
    private Drawable createDefaultButtonDrawable(int sizePx) { 
        Bitmap bmp = Bitmap.createBitmap(sizePx, sizePx, Bitmap.Config.ARGB_8888); 
        Canvas c = new Canvas(bmp); 
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG); 
 
        // Background circle 
        p.setColor(0xAA000000); 
        c.drawCircle(sizePx / 2f, sizePx / 2f, sizePx / 2f, p); 
 
        // White X 
        p.setColor(Color.WHITE); 
        p.setStrokeWidth(sizePx * 0.12f); 
        p.setStrokeCap(Paint.Cap.ROUND); 
        float pad = sizePx * 0.3f; 
        c.drawLine(pad, pad, sizePx - pad, sizePx - pad, p); 
        c.drawLine(sizePx - pad, pad, pad, sizePx - pad, p); 
 
        return new BitmapDrawable(activity.getResources(), bmp); 
    } 
} 
