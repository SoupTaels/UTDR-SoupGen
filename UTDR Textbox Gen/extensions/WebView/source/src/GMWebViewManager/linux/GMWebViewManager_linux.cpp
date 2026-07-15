#include "common/GMWebViewManager_common.h"

#include <gtk/gtk.h>
#include <gdk/gdk.h>
#include <gdk/gdkpixbuf.h>

#include <mutex>
#include <atomic>
#include <string>
#include <cstring>
#include <cerrno>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

using namespace webviewcpp;

static std::filesystem::path appassets_folder()
{
    return std::filesystem::temp_directory_path() / "gmwebview_appassets";
}

// --- tiny local HTTP server (loopback only) ---
namespace {
std::once_flag g_yt_once;
std::once_flag g_yt_atexit_once;  // Ensure atexit is only registered once
std::atomic<bool> g_yt_running {false};
std::atomic<int> g_yt_port {0};
int g_listen_fd = -1;
std::thread g_yt_thread;

static void close_fd(int& fd)
{
    if (fd >= 0) {
        ::close(fd);
        fd = -1;
    }
}

static std::string http_response_404()
{
    return "HTTP/1.1 404 Not Found\r\n"
           "Content-Length: 0\r\n"
           "Connection: close\r\n\r\n";
}

static std::string http_response_file(const std::string& body, const char* content_type)
{
    std::string h = "HTTP/1.1 200 OK\r\n";
    h += "Content-Type: ";
    h += content_type;
    h += "\r\nContent-Length: ";
    h += std::to_string(body.size());
    h += "\r\nConnection: close\r\n\r\n";
    return h + body;
}

static bool read_whole_file(const std::filesystem::path& p, std::string& out)
{
    std::ifstream in(p, std::ios::binary);
    if (!in)
        return false;
    out.assign(std::istreambuf_iterator<char>(in), std::istreambuf_iterator<char>());
    return true;
}

static void yt_server_loop(std::filesystem::path root)
{
    g_yt_running = true;

    while (g_yt_running.load()) {
        sockaddr_in cli {};
        socklen_t clen = sizeof(cli);
        int cfd = ::accept(g_listen_fd, (sockaddr*)&cli, &clen);
        if (cfd < 0) {
            if (!g_yt_running.load())
                break;
            continue;
        }

        // read minimal request
        char buf[4096];
        int n = ::recv(cfd, buf, (int)sizeof(buf) - 1, 0);
        if (n <= 0) {
            close_fd(cfd);
            continue;
        }
        buf[n] = 0;

        // parse "GET /path HTTP/1.1"
        std::string req(buf);
        std::string path;
        {
            auto p0 = req.find("GET ");
            auto p1 = (p0 == std::string::npos) ? std::string::npos : req.find(' ', p0 + 4);
            if (p0 != std::string::npos && p1 != std::string::npos) {
                path = req.substr(p0 + 4, p1 - (p0 + 4));
            }
        }

        // only serve our single file (allow querystring)
        auto qpos = path.find('?');
        std::string path_no_q = (qpos == std::string::npos) ? path : path.substr(0, qpos);

        if (path_no_q == "/" || path_no_q.empty())
            path_no_q = std::string("/") + kYTPageName;

        // normalize
        if (!path_no_q.empty() && path_no_q[0] == '/')
            path_no_q.erase(0, 1);

        const auto file = root / path_no_q;

        std::string body;
        std::string resp;

        if (path_no_q == kYTPageName && read_whole_file(file, body)) {
            resp = http_response_file(body, "text/html; charset=utf-8");
        } else {
            resp = http_response_404();
        }

        ::send(cfd, resp.data(), (int)resp.size(), 0);
        close_fd(cfd);
    }

    close_fd(g_listen_fd);
}

static void stop_yt_server()
{
    g_yt_running = false;
    if (g_listen_fd >= 0) {
        // wake accept()
        ::shutdown(g_listen_fd, SHUT_RDWR);
    }
    if (g_yt_thread.joinable())
        g_yt_thread.join();
}

static int start_loopback_server(const std::filesystem::path& root)
{
    int fd = ::socket(AF_INET, SOCK_STREAM, 0);
    if (fd < 0)
        return 0;

    int yes = 1;
    ::setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes));

    sockaddr_in addr {};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    addr.sin_port = htons(0); // ephemeral

    if (::bind(fd, (sockaddr*)&addr, sizeof(addr)) != 0) {
        close_fd(fd);
        return 0;
    }

    if (::listen(fd, 8) != 0) {
        close_fd(fd);
        return 0;
    }

    // get assigned port
    sockaddr_in bound {};
    socklen_t blen = sizeof(bound);
    if (::getsockname(fd, (sockaddr*)&bound, &blen) != 0) {
        close_fd(fd);
        return 0;
    }

    g_listen_fd = fd;
    int port = (int)ntohs(bound.sin_port);

    g_yt_thread = std::thread(yt_server_loop, root);

    // Register atexit handler only once (fallback cleanup at program termination)
    std::call_once(g_yt_atexit_once, [] {
        std::atexit(stop_yt_server);
    });

    return port;
}
} // namespace

// Call once per webview instance (safe to call multiple times).
static void _ensureYoutubeAppassetsReady(webview::webview*)
{
    std::call_once(g_yt_once, [&]() {
        const auto folder = appassets_folder();
        _writeYoutubeIframeApiPage(folder);
        const int port = start_loopback_server(folder);
        g_yt_port = port;
    });

    // If server failed to start, leave port=0; caller can fallback.
}

std::string _buildYoutubeUrl(const std::string& id)
{
    const int port = g_yt_port.load();
    if (port <= 0)
        return std::string();
    return "http://127.0.0.1:" + std::to_string(port) + "/" + kYTPageName + "?id=" + id;
}

// Hide the window
void _hideWindow(void* winPtr) { gtk_widget_hide((GtkWidget*)winPtr); }

// Show the window
void _showWindow(void* winPtr) { gtk_widget_show_all((GtkWidget*)winPtr); }

// Toggle borderless (frameless) style
void _setBorderless(void* winPtr, bool on)
{
    GtkWidget* win = (GtkWidget*)winPtr;
    gtk_window_set_decorated(GTK_WINDOW(win), on ? FALSE : TRUE);
    gtk_widget_show_all(win);
}

void GMWebViewManager::ensure()
{
    // Linux: create ONCE, keep loop alive. Never terminate on close().
    if (g_webview_instance_ || (running_.load(std::memory_order_acquire) && ready_.load(std::memory_order_acquire)))
        return;

    // If a previous thread exists but isn't running (shouldn't happen with keepalive),
    // join it before creating a new one.
    if (ui_thread_.joinable() && !running_.load(std::memory_order_acquire)) {
        ui_thread_.join();
    }

    ready_.store(false, std::memory_order_release);
    running_.store(true, std::memory_order_release);

    ui_thread_ = std::thread([this] {
        auto local = std::make_shared<webview::webview>(true, nullptr);
        webview::webview* wraw = local.get();

        // Initial sizing / window
        wraw->set_size(800, 600, WEBVIEW_HINT_NONE);

        // Bind on UI thread
        wraw->bind("gm_post", [this](std::string req) {
            onInvoke(req);
            return std::string();
        });

        // Inject on UI thread
        wraw->init(kInjectJS);

        // YouTube appassets / localhost server setup etc.
        _ensureYoutubeAppassetsReady(wraw);

        // Publish instance + mark ready
        {
            std::lock_guard<std::mutex> lk(m_);
            g_webview_instance_ = local;
            ready_.store(true, std::memory_order_release);
        }
        cv_.notify_all();

        // Respect start mode on Linux
        {
            auto r = wraw->window();
            if (r.has_value()) {
                auto v = r.value();
                if (start_mode_ == WebViewStartMode::Hidden) {
                    _hideWindow(v);
                    visible_.store(false, std::memory_order_release);
                } else {
                    _showWindow(v);
                    visible_.store(true, std::memory_order_release);
                }
            }
        }

        // Run loop (keep alive)
        wraw->run();

        // If run() ever returns (should normally only be at program exit)
        {
            std::lock_guard<std::mutex> lk(m_);
            g_webview_instance_.reset();
            ready_.store(false, std::memory_order_release);
            running_.store(false, std::memory_order_release);
            visible_.store(false, std::memory_order_release);
        }
    });

    // Wait until ready (avoid deadlock: use timeout)
    std::unique_lock<std::mutex> lk(m_);
    cv_.wait_for(lk, std::chrono::seconds(5), [&] { return ready_.load(std::memory_order_acquire); });
    return;
}

void GMWebViewManager::open(const std::string& url)
{
    ensure();
    loading_ = true;

    // snapshot shared_ptr under lock
    std::shared_ptr<webview::webview> w;
    {
        std::lock_guard<std::mutex> lk(m_);
        w = g_webview_instance_;
    }
    if (!w)
        return;

    const std::string urlCopy = url;

    w->dispatch([this, w, urlCopy] {
        // Show window
        auto r = w->window();
        if (r.has_value()) {
            _showWindow(r.value());
            visible_.store(true, std::memory_order_release);
        }

        // Navigate
        w->navigate(urlCopy);
    });

    return;
}

void GMWebViewManager::close()
{
    // On Linux, do NOT terminate WebKit. Just hide and reset.
    if (!running_.load(std::memory_order_acquire))
        return;

    std::shared_ptr<webview::webview> w;
    {
        std::lock_guard<std::mutex> lk(m_);
        w = g_webview_instance_;
    }
    if (!w)
        return;

    {
        std::lock_guard<std::mutex> lk(btn_state_mtx_);
        btn_state_.clear();
    }

    w->dispatch([this, w] {
        // Stop all media playback BEFORE navigating to about:blank
        try {
            const char* stopMediaJS =
                "(function(){"
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
            w->eval(stopMediaJS);
        } catch (...) {
        }

        // Remove UI buttons
        try {
            w->eval("if(window.GMUI){GMUI.remAll();}");
        } catch (...) {
        }

        // Then navigate to blank
        try {
            w->navigate("about:blank");
        } catch (...) {
        }

        // Hide the window
        auto r = w->window();
        if (r.has_value()) {
            _hideWindow(r.value());
            visible_.store(false, std::memory_order_release);
        }
    });

    // logical close only
    loading_ = false;
    return;
}

void GMWebViewManager::hide()
{
    std::shared_ptr<webview::webview> w;
    {
        std::lock_guard<std::mutex> lk(m_);
        w = g_webview_instance_;
    }
    if (!w) return;

    dispatch([this, w] {
        auto r = w->window();
        if (r.has_value()) {
            _hideWindow(r.value());
            visible_.store(false, std::memory_order_release);
        }
    });
}

void GMWebViewManager::show()
{
    std::shared_ptr<webview::webview> w;
    {
        std::lock_guard<std::mutex> lk(m_);
        w = g_webview_instance_;
    }
    if (!w) return;

    dispatch([this, w] {
        auto r = w->window();
        if (r.has_value()) {
            _showWindow(r.value());
            visible_.store(true, std::memory_order_release);
        }
    });
}

void GMWebViewManager::setBorderless(bool on)
{
    std::shared_ptr<webview::webview> w;
    {
        std::lock_guard<std::mutex> lk(m_);
        w = g_webview_instance_;
    }
    if (!w) return;

    dispatch([w, on] {
        auto r = w->window();
        if (!r.has_value())
            return;

        _setBorderless(r.value(), on);
    });
}