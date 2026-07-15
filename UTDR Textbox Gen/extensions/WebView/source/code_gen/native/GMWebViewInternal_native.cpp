// ##### extgen :: Auto-generated file do not edit!! #####

#include "GMWebViewInternal_native.h"
#include "GMWebViewInternal_exports.h"

using namespace gm_structs;
using namespace gm::wire::codec;

static gm::runtime::DispatchQueue __dispatch_queue;

// Internal function used for fetching dispatched function calls to GML
GMEXPORT double __EXT_NATIVE__GMWebView_invocation_handler(char* __ret_buffer, double __ret_buffer_length)
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

GMEXPORT double __EXT_NATIVE__webview_open_url(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: url, type: optional<String>
    std::optional<std::string_view> url = gm::wire::codec::readOptional<std::string_view>(__br);

    webview_open_url(url);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_hide()
{
    webview_hide();
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_show()
{
    webview_show();
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_close()
{
    webview_close();
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_load_html(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: html, type: optional<String>
    std::optional<std::string_view> html = gm::wire::codec::readOptional<std::string_view>(__br);

    webview_load_html(html);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_load_local(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: path, type: optional<String>
    std::optional<std::string_view> path = gm::wire::codec::readOptional<std::string_view>(__br);

    webview_load_local(path);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_load_blank()
{
    webview_load_blank();
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_load_youtube(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: uid, type: optional<String>
    std::optional<std::string_view> uid = gm::wire::codec::readOptional<std::string_view>(__br);

    webview_load_youtube(uid);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_load_no_internet()
{
    webview_load_no_internet();
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_set_start_mode(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: mode, type: enum WebViewStartMode
    gm_enums::WebViewStartMode mode = gm::wire::codec::readValue<gm_enums::WebViewStartMode>(__br);

    webview_set_start_mode(mode);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_set_borderless(double on)
{
    webview_set_borderless(static_cast<bool>(on));
    return 0;
}

GMEXPORT char* __EXT_NATIVE__webview_get_url()
{
    static std::string __result;
    __result = webview_get_url();
    return (char*)__result.c_str();
}

GMEXPORT char* __EXT_NATIVE__webview_get_title()
{
    static std::string __result;
    __result = webview_get_title();
    return (char*)__result.c_str();
}

GMEXPORT double __EXT_NATIVE__webview_is_loading()
{
    auto&& __result = webview_is_loading();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__webview_is_running()
{
    auto&& __result = webview_is_running();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__webview_is_visible()
{
    auto&& __result = webview_is_visible();
    return static_cast<double>(__result);
}

GMEXPORT char* __EXT_NATIVE__webview_get_body()
{
    static std::string __result;
    __result = webview_get_body();
    return (char*)__result.c_str();
}

GMEXPORT char* __EXT_NATIVE__webview_get_params()
{
    static std::string __result;
    __result = webview_get_params();
    return (char*)__result.c_str();
}

GMEXPORT double __EXT_NATIVE__webview_allow_swipe_refresh(double allow)
{
    webview_allow_swipe_refresh(static_cast<bool>(allow));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_eval_js(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: js, type: optional<String>
    std::optional<std::string_view> js = gm::wire::codec::readOptional<std::string_view>(__br);

    webview_eval_js(js);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_set_js_callback(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: cb, type: optional<Function>
    std::optional<gm::wire::GMFunction> cb = std::nullopt;
    if (gm::wire::codec::readValue<bool>(__br))
    {
        cb = gm::wire::codec::readFunction(__br, &__dispatch_queue);
    }

    webview_set_js_callback(cb);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_create(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: size_dp, type: Int32
    std::int32_t size_dp = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: gravity, type: Int32
    std::int32_t gravity = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: asset_type, type: optional<enum WebViewButtonAssetType>
    std::optional<gm_enums::WebViewButtonAssetType> asset_type = gm::wire::codec::readOptional<gm_enums::WebViewButtonAssetType>(__br);

    // field: asset, type: optional<String>
    std::optional<std::string_view> asset = gm::wire::codec::readOptional<std::string_view>(__br);

    auto&& __result = webview_button_create(size_dp, gravity, asset_type, asset);
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__webview_button_destroy(double handle)
{
    webview_button_destroy(static_cast<std::int32_t>(handle));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_destroy_all()
{
    webview_button_destroy_all();
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_alpha(double handle, double alpha)
{
    webview_button_set_alpha(static_cast<std::int32_t>(handle), static_cast<double>(alpha));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_auto_close(double handle, double flag)
{
    webview_button_set_auto_close(static_cast<std::int32_t>(handle), static_cast<bool>(flag));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_margins(double handle, double left, double top, double right, double bottom)
{
    webview_button_set_margins(static_cast<std::int32_t>(handle), static_cast<std::int32_t>(left), static_cast<std::int32_t>(top), static_cast<std::int32_t>(right), static_cast<std::int32_t>(bottom));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_size(double handle, double size_dp)
{
    webview_button_set_size(static_cast<std::int32_t>(handle), static_cast<std::int32_t>(size_dp));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_gravity(double handle, double gravity)
{
    webview_button_set_gravity(static_cast<std::int32_t>(handle), static_cast<std::int32_t>(gravity));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_position(double handle, double x_dp, double y_dp)
{
    webview_button_set_position(static_cast<std::int32_t>(handle), static_cast<std::int32_t>(x_dp), static_cast<std::int32_t>(y_dp));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_visible(double handle, double visible)
{
    webview_button_set_visible(static_cast<std::int32_t>(handle), static_cast<bool>(visible));
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_asset(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: handle, type: Int32
    std::int32_t handle = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: asset_type, type: enum WebViewButtonAssetType
    gm_enums::WebViewButtonAssetType asset_type = gm::wire::codec::readValue<gm_enums::WebViewButtonAssetType>(__br);

    // field: asset, type: optional<String>
    std::optional<std::string_view> asset = gm::wire::codec::readOptional<std::string_view>(__br);

    webview_button_set_asset(handle, asset_type, asset);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_button_set_callback(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: handle, type: Int32
    std::int32_t handle = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: callback, type: optional<Function>
    std::optional<gm::wire::GMFunction> callback = std::nullopt;
    if (gm::wire::codec::readValue<bool>(__br))
    {
        callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);
    }

    webview_button_set_callback(handle, callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__webview_shutdown()
{
    webview_shutdown();
    return 0;
}

