
#include "common/GMWebViewManager_common.h"

#include <windows.h>
#include <shellapi.h>

using namespace webviewcpp;

static const wchar_t* kAppAssetsHost = L"appassets.local";

static std::filesystem::path appassets_folder()
{
    // Put your runtime assets in a stable folder.
    // temp_directory_path is fine for a generated file.
    return std::filesystem::temp_directory_path() / "gmwebview_appassets";
}

static void webview2_map_appassets(webview::webview* w, const std::filesystem::path& folder)
{
    if (!w)
        return;

    auto ctrlRes = w->browser_controller();
    if (!ctrlRes.ok())
        return;

    auto* controller = static_cast<ICoreWebView2Controller*>(ctrlRes.value());
    if (!controller)
        return;

    ICoreWebView2* core = nullptr;
    if (FAILED(controller->get_CoreWebView2(&core)) || !core)
        return;

    ICoreWebView2_3* core3 = nullptr;
    if (SUCCEEDED(core->QueryInterface(IID_PPV_ARGS(&core3))) && core3) {
        // Allow access to files under the mapped host.
        core3->SetVirtualHostNameToFolderMapping(
            kAppAssetsHost, folder.wstring().c_str(), COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_ALLOW
        );
        core3->Release();
    }

    core->Release();
}

static void webview2_lockdown_ui(webview::webview* w, bool disableContextMenu, bool disableDevTools)
{
    if (!w)
        return;

    auto ctrlRes = w->browser_controller();
    if (!ctrlRes.ok())
        return;

    auto* controller = static_cast<ICoreWebView2Controller*>(ctrlRes.value());
    if (!controller)
        return;

    ICoreWebView2* core = nullptr;
    if (FAILED(controller->get_CoreWebView2(&core)) || !core)
        return;

    ICoreWebView2Settings* settings = nullptr;
    if (SUCCEEDED(core->get_Settings(&settings)) && settings) {
        if (disableContextMenu)
            settings->put_AreDefaultContextMenusEnabled(FALSE); // disables right-click menu

        if (disableDevTools)
            settings->put_AreDevToolsEnabled(FALSE); // disables DevTools entry points

        settings->Release();
    }

    core->Release();
}

// Call once per webview instance (safe to call multiple times).
static void _ensureYoutubeAppassetsReady(webview::webview* w)
{
    static std::once_flag once;
    std::call_once(once, [&]() {
        const auto folder = appassets_folder();
        _writeYoutubeIframeApiPage(folder);
        // Mapping must happen against a created WebView2 instance:
        webview2_map_appassets(w, folder);
    });

    // If mapping didn’t happen due to early call timing, calling again is harmless.
    // But because once_flag only runs once, we attempt mapping again every call:
    webview2_map_appassets(w, appassets_folder());
}

std::string _buildYoutubeUrl(const std::string& id)
{
    return std::string("https://") + "appassets.local/" + kYTPageName + "?id=" + id;
}

void _loadYouTube(const std::string& id, GMWebViewManager& wvm)
{
    const std::string url = std::string("https://") + "appassets.local/" + kYTPageName + "?id=" + id;
    wvm.open(url);
}

// Hide the window
static void _hideWindow(void* winPtr) { ::ShowWindow((HWND)winPtr, SW_HIDE); }

// Show the window
static void _showWindow(void* winPtr)
{
    ::ShowWindow((HWND)winPtr, SW_SHOW);
    ::SetForegroundWindow((HWND)winPtr);
}

// Toggle borderless (frameless) style
static void _setBorderless(void* winPtr, bool on)
{
    HWND h = (HWND)winPtr;

    // Remove/add frame & buttons
    LONG_PTR style = GetWindowLongPtr(h, GWL_STYLE);
    if (on) {
        style &= ~(WS_CAPTION | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_SYSMENU);
        // Optional: WS_POPUP for completely frameless (no resize)
        // style = (style & ~WS_OVERLAPPEDWINDOW) | WS_POPUP;
    } else {
        style |= (WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_THICKFRAME);
    }
    SetWindowLongPtr(h, GWL_STYLE, style);
    // Recalc non-client area
    SetWindowPos(h, nullptr, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED);
}

void GMWebViewManager::ensure()
{

    if (destroying_.load(std::memory_order_acquire))
        return;

    if (ui_thread_.joinable() && !running_.load(std::memory_order_acquire))
        ui_thread_.join();

    if (running_.load(std::memory_order_acquire))
        return;

    ready_ = false;
    running_ = true;

    ui_thread_ = std::thread([this] {
        CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED); // STA for WebView2

        auto local = std::make_shared<webview::webview>(true, nullptr);

        webview::webview* wraw = local.get();

        // 2) Apply initial state
        wraw->set_size(1, 1, WEBVIEW_HINT_NONE);
        auto r = wraw->window();
        if (r.has_value()) {
            auto v = r.value();
            switch (start_mode_) {
            case WebViewStartMode::Hidden:
                _hideWindow(v);
                visible_ = false;
                break;
            default:
                _showWindow(v);
                visible_ = true;
                break;
            }
        }

        wraw->set_size(800, 600, WEBVIEW_HINT_NONE);

        // 2) Bind ON THIS THREAD
        wraw->bind("gm_post", [this](std::string req) {
            onInvoke(req);
            return std::string();
        });

        // 3) Inject ON THIS THREAD
        wraw->init(kInjectJS);

        // IMPORTANT: Give YouTube a real HTTPS referer identity using Virtual Host Mapping.
        _ensureYoutubeAppassetsReady(wraw);

        webview2_lockdown_ui(wraw, true, true);

        {
            std::lock_guard<std::mutex> lk(m_);
            g_webview_instance_ = local;
            ready_ = true;

            // flush pending safely
            for (auto& fn : pending_) {
                local->dispatch([local, fn] { fn(); });
            }
            pending_.clear();
        }
        cv_.notify_all();

        wraw->run();

        {
            std::lock_guard<std::mutex> lk(m_);
            g_webview_instance_.reset();
            ready_ = false;
            running_ = false;
        }
        CoUninitialize();
    });

    std::unique_lock<std::mutex> lk(m_);
    if (!cv_.wait_for(lk, std::chrono::seconds(5), [&] { return ready_.load(); })) {
        // failed to become ready — roll back
        running_ = false;
    }
}

void GMWebViewManager::open(const std::string& url)
{
    if (destroying_.load(std::memory_order_acquire))
        return;

    ensure();
    loading_ = true;

    const std::string urlCopy = url;

    dispatch([this, urlCopy] {
        std::shared_ptr<webview::webview> w;
        {
            std::lock_guard<std::mutex> lk(m_);
            w = g_webview_instance_;
        }
        if (!w)
            return;

        // Navigate.
        w->navigate(urlCopy);
    });
}

void GMWebViewManager::close()
{
    if (!running_.load(std::memory_order_acquire))
        return;

    if (destroying_.exchange(true, std::memory_order_acq_rel))
        return;

    const uint64_t my_gen = close_gen_.fetch_add(1, std::memory_order_acq_rel) + 1;

    std::shared_ptr<webview::webview> w;
    std::thread t;
    void* winPtr = nullptr;

    {
        std::lock_guard<std::mutex> lk(m_);
        w = g_webview_instance_;
        if (w) {
            auto r = w->window();
            if (r.has_value())
                winPtr = r.value();
        }
        t = std::move(ui_thread_);
        ui_thread_ = std::thread();
    }

    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        btn_state_.clear();
    }

    // Try to close the native window first — this forces the message loop to react.
    if (winPtr) {
        HWND hwnd = (HWND)winPtr;
        ::PostMessageW(hwnd, WM_CLOSE, 0, 0);
    }

    std::thread([this, my_gen, t = std::move(t), w = std::move(w)]() mutable {
        if (t.joinable() && std::this_thread::get_id() != t.get_id())
            t.join();

        if (close_gen_.load(std::memory_order_acquire) != my_gen)
            return;

        {
            std::lock_guard<std::mutex> lk(m_);
            g_webview_instance_.reset();
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
    }).detach();
}

void GMWebViewManager::hide()
{
    dispatch([this] {
        std::shared_ptr<webview::webview> w;
        {
            std::lock_guard<std::mutex> lk(m_);
            w = g_webview_instance_;
        }
        if (!w)
            return;

        auto r = w->window();
        if (r.has_value()) {
            _hideWindow(r.value());
            visible_.store(false, std::memory_order_release);
        }
    });
}

void GMWebViewManager::show()
{
    dispatch([this] {
        std::shared_ptr<webview::webview> w;
        {
            std::lock_guard<std::mutex> lk(m_);
            w = g_webview_instance_;
        }
        if (!w)
            return;

        auto r = w->window();
        if (r.has_value()) {
            _showWindow(r.value());
            visible_.store(true, std::memory_order_release);
        }
    });
}

void GMWebViewManager::setBorderless(bool on)
{
    dispatch([this, on] {
        std::shared_ptr<webview::webview> w;
        {
            std::lock_guard<std::mutex> lk(m_);
            w = g_webview_instance_;
        }
        if (!w)
            return;

        auto r = w->window();
        if (r.has_value()) {
            _setBorderless(r.value(), on);
        }
    });
}