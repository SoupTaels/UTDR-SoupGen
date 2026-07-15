// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#include <cstdint>
#include <string_view>
#include <vector>
#include <array>
#include <optional>
#include "core/GMExtWire.h"

namespace gm_consts
{
}


namespace gm_enums
{
    enum class WebViewJavaScriptEvent : std::uint8_t
    {
        OnUrlChange = 0,
        OnBodyChange = 1,
        OnTitleChange = 2,
        OnButtonPress = 3,
        OnPageLoadStart = 4,
        OnPageLoadEnd = 5,
        OnCustomPost = 6
    };

    enum class WebViewStartMode : std::uint8_t
    {
        Hidden = 0,
        Visible = 1
    };

    enum class WebViewButtonAssetType : std::uint8_t
    {
        DefaultIcon = 0,
        FilePath = 1,
        Base64Data = 2,
        RawData = 3
    };

    enum class WebViewButtonGravity : std::uint32_t
    {
        Left = 3,
        Right = 5,
        Top = 48,
        Bottom = 80,
        Start = 8388611,
        End = 8388613,
        CenterHorizontal = 1,
        CenterVertical = 16,
        Center = 17
    };

}


namespace gm_structs
{

}

namespace gm::wire::codec
{
}

namespace gm::wire::details
{
}

void webview_open_url(std::optional<std::string_view> url);
void webview_hide();
void webview_show();
void webview_close();
void webview_load_html(std::optional<std::string_view> html);
void webview_load_local(std::optional<std::string_view> path);
void webview_load_blank();
void webview_load_youtube(std::optional<std::string_view> uid);
void webview_load_no_internet();
void webview_set_start_mode(gm_enums::WebViewStartMode mode);
void webview_set_borderless(bool on);
std::string webview_get_url();
std::string webview_get_title();
bool webview_is_loading();
bool webview_is_running();
bool webview_is_visible();
std::string webview_get_body();
std::string webview_get_params();
void webview_allow_swipe_refresh(bool allow);
void webview_eval_js(std::optional<std::string_view> js);
void webview_set_js_callback(const std::optional<gm::wire::GMFunction>& cb);
std::int32_t webview_button_create(std::int32_t size_dp, std::int32_t gravity, std::optional<gm_enums::WebViewButtonAssetType> asset_type, std::optional<std::string_view> asset);
void webview_button_destroy(std::int32_t handle);
void webview_button_destroy_all();
void webview_button_set_alpha(std::int32_t handle, double alpha);
void webview_button_set_auto_close(std::int32_t handle, bool flag);
void webview_button_set_margins(std::int32_t handle, std::int32_t left, std::int32_t top, std::int32_t right, std::int32_t bottom);
void webview_button_set_size(std::int32_t handle, std::int32_t size_dp);
void webview_button_set_gravity(std::int32_t handle, std::int32_t gravity);
void webview_button_set_position(std::int32_t handle, std::int32_t x_dp, std::int32_t y_dp);
void webview_button_set_visible(std::int32_t handle, bool visible);
void webview_button_set_asset(std::int32_t handle, gm_enums::WebViewButtonAssetType asset_type, std::optional<std::string_view> asset);
void webview_button_set_callback(std::int32_t handle, const std::optional<gm::wire::GMFunction>& callback);
void webview_shutdown();
