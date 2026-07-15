#pragma once
#include <string>
#include <memory>
#include <mutex>
#include <atomic>
#include <vector>
#include <thread>
#include <functional>
#include "core/GMExtWire.h"

namespace webviewcpp {

enum class WebViewStartMode : std::uint8_t {
    Hidden,
    Visible,
};

enum class WebViewButtonAssetType : std::uint8_t { DefaultIcon, FilePath, Base64Data, RawData };

enum class WebViewButtonGravity : std::uint32_t {
    Left = 0x03,
    Right = 0x05,
    Top = 0x30,
    Bottom = 0x50,
    Start = 0x800003,
    End = 0x800005,
    CenterHorizontal = 0x01,
    CenterVertical = 0x10,
    Center = 0x11,
};

enum class WebViewJavaScriptEvent : std::uint8_t {
    OnUrlChange,
    OnBodyChange,
    OnTitleChange,
    OnButtonPress,
    OnPageLoadStart,
    OnPageLoadEnd,
    OnCustomPost
};

class GMWebViewManager {
public:
    using JSCallback = std::function<void(const char* js)>;
    static GMWebViewManager& instance();

    ~GMWebViewManager();

    // lifecycle / content
    void open(const std::string& url);
    void hide();
    void show();
    void close();

    void loadLocal(const std::string& pathOrHtml, bool isRawHtml);
    void loadBlank();
    void loadYouTube(const std::string& idOrUrl);
    void loadNoInternet();

    void setStartMode(WebViewStartMode mode);

    void setBorderless(bool on);

    // info
    std::string url() const;
    std::string title() const;
    bool isLoading() const;
    bool isRunning() const;
    bool isVisible() const;
    std::string body() const;
    std::string params() const;

    // js bridge
    void evalJS(const std::string& js);
    void evalJS_unsafe(const std::string& js);
    void setJSCallback(const gm::wire::GMFunction &cb);

    // behavior (stub)
    void allowSwipeRefresh(bool) {}
    
    // overlay buttons (DOM)
    int buttonCreate(int sizeDp, int gravity, WebViewButtonAssetType assetType, const std::string& asset);
    void buttonDestroy(int handle);
    void buttonDestroyAll();

    void buttonSetAlpha(int handle, double alpha0to1);
    void buttonSetAutoClose(int handle, bool flag);
    void buttonSetMargins(int handle, int lDp, int tDp, int rDp, int bDp);
    void buttonSetSize(int handle, int sizeDp);
    void buttonSetGravity(int handle, int gravity);    // switch to gravity mode
    void buttonSetPosition(int handle, int xDp, int yDp); // switch to absolute mode
    void buttonShow(int handle);
    void buttonHide(int handle);
    void buttonSetAsset(int handle, WebViewButtonAssetType assetType, const std::string &asset);
    void buttonSetCallback(int handle, gm::wire::GMFunction cb);
    void buttonClearCallback(int handle);

    // exposed to bind() handler
    void onInvoke(const std::string& msg);

private:
    GMWebViewManager() = default;
    GMWebViewManager(const GMWebViewManager&) = delete;
    GMWebViewManager& operator=(const GMWebViewManager&) = delete;
    GMWebViewManager(GMWebViewManager&&) = delete;
    GMWebViewManager& operator=(GMWebViewManager&&) = delete;

    void ensure();
    void dispatch(const std::function<void()>& fn);

    void ensureButtons();
    void requestDestroyFromDom();
    void joinUiThread();

    int next_handle_ = 1; // reset on close()

    struct ButtonState {
        std::string src;
        int sizeDp = 0;
        int gravity = (std::int32_t)WebViewButtonGravity::Center;
        int ml=12, mt=12, mr=12, mb=12;
        bool autoClose = false;

        bool absolute = false;
        int xDp = 0, yDp = 0;

        double alpha = 1.0;
        bool hidden = false;
        gm::wire::GMFunction cb = nullptr;
    };

    std::unordered_map<int, ButtonState> btn_state_;

    std::thread ui_thread_;
    mutable std::mutex m_, cb_mtx_, btn_state_mtx_;
    std::string last_url_, last_title_, last_body_, last_params_;
    gm::wire::GMFunction js_callback_ = nullptr;
    std::condition_variable cv_;
    std::atomic<bool> ready_ {false}; // bind+inject done and w_ published
    std::atomic<bool> loading_ {false};
    std::atomic<bool> running_ {false}; // run() currently active
    std::atomic<bool> visible_ {false}; // run() currently active
    std::atomic<bool> destroying_ {false};
    std::vector<std::function<void()>> pending_;

    WebViewStartMode start_mode_ = WebViewStartMode::Visible;

    std::atomic<uint64_t> close_gen_{0};   // increments per close()
    std::atomic<bool> shutdown_requested_{false};
};

} // namespace webviewcpp