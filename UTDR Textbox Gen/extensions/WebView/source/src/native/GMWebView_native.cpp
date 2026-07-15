#include "GMWebView_native.h"
#include "GMWebViewManager/GMWebViewManager.h"

using namespace gm::wire;
using namespace gm_structs;

static webviewcpp::GMWebViewManager& GMWebViewManager() { return webviewcpp::GMWebViewManager::instance(); }

void webview_open_url(std::optional<std::string_view> url)
{
    GMWebViewManager().open(std::string(url.value_or("about:blank")));
}

void webview_hide() { GMWebViewManager().hide(); }

void webview_show() { GMWebViewManager().show(); }

void webview_close() { GMWebViewManager().close(); }

void webview_load_html(std::optional<std::string_view> html)
{
    GMWebViewManager().loadLocal(std::string(html.value_or("")), true);
}

void webview_load_local(std::optional<std::string_view> path)
{
    GMWebViewManager().loadLocal(std::string(path.value_or("")), false);
}

void webview_load_blank() { GMWebViewManager().loadBlank(); }

void webview_load_youtube(std::optional<std::string_view> uid)
{
    GMWebViewManager().loadYouTube(std::string(uid.value_or("")));
}

void webview_load_no_internet() { GMWebViewManager().loadNoInternet(); }

void webview_set_start_mode(gm_enums::WebViewStartMode mode)
{
    GMWebViewManager().setStartMode((webviewcpp::WebViewStartMode)mode);
}

void webview_set_borderless(bool on) { GMWebViewManager().setBorderless(on); }

std::string webview_get_url() { return GMWebViewManager().url(); }

std::string webview_get_title() { return GMWebViewManager().title(); }

bool webview_is_loading() { return GMWebViewManager().isLoading(); }

bool webview_is_running() { return GMWebViewManager().isRunning(); }

bool webview_is_visible() { return GMWebViewManager().isVisible(); }

std::string webview_get_body() { return GMWebViewManager().body(); }

std::string webview_get_params() { return GMWebViewManager().params(); }

void webview_allow_swipe_refresh(bool allow) { GMWebViewManager().allowSwipeRefresh(allow); }

void webview_eval_js(std::optional<std::string_view> js) { GMWebViewManager().evalJS(std::string(js.value_or(""))); }

void webview_set_js_callback(const std::optional<gm::wire::GMFunction>& cb)
{
    GMWebViewManager().setJSCallback(cb.value_or(nullptr));
}

std::int32_t webview_button_create(
    std::int32_t size_dp,
    std::int32_t gravity,
    std::optional<gm_enums::WebViewButtonAssetType> asset_type,
    std::optional<std::string_view> asset_path
)
{

    int handle = GMWebViewManager().buttonCreate(
        size_dp,
        gravity,
        (webviewcpp::WebViewButtonAssetType)asset_type.value_or(gm_enums::WebViewButtonAssetType::DefaultIcon),
        std::string(asset_path.value_or(""))
    );
    return handle;
}

void webview_button_destroy(std::int32_t handle) { GMWebViewManager().buttonDestroy(handle); }

void webview_button_destroy_all() { GMWebViewManager().buttonDestroyAll(); }

void webview_button_set_alpha(std::int32_t handle, double alpha) { GMWebViewManager().buttonSetAlpha(handle, alpha); }

void webview_button_set_auto_close(std::int32_t handle, bool flag)
{
    GMWebViewManager().buttonSetAutoClose(handle, flag);
}

void webview_button_set_margins(
    std::int32_t handle, std::int32_t left, std::int32_t top, std::int32_t right, std::int32_t bottom
)
{
    GMWebViewManager().buttonSetMargins(handle, left, top, right, bottom);
}

void webview_button_set_size(std::int32_t handle, std::int32_t size_dp)
{
    GMWebViewManager().buttonSetSize(handle, size_dp);
}

void webview_button_set_gravity(std::int32_t handle, std::int32_t gravity)
{
    GMWebViewManager().buttonSetGravity(handle, gravity);
}

void webview_button_set_position(std::int32_t handle, std::int32_t x_dp, std::int32_t y_dp)
{
    GMWebViewManager().buttonSetPosition(handle, x_dp, y_dp);
}

void webview_button_set_visible(std::int32_t handle, bool visible)
{
    if (visible)
        GMWebViewManager().buttonShow(handle);
    else
        GMWebViewManager().buttonHide(handle);
}

void webview_button_set_asset(
    std::int32_t handle, gm_enums::WebViewButtonAssetType asset_type, std::optional<std::string_view> asset
)
{
    GMWebViewManager().buttonSetAsset(
        handle, (webviewcpp::WebViewButtonAssetType)asset_type, std::string(asset.value_or(""))
    );
}

void webview_button_set_callback(std::int32_t handle, const std::optional<gm::wire::GMFunction>& callback)
{
    if (callback)
        GMWebViewManager().buttonSetCallback(handle, callback.value());
    else
        GMWebViewManager().buttonClearCallback(handle);
}

void webview_shutdown() { GMWebViewManager().close(); }
