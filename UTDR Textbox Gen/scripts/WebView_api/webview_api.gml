// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

enum WebViewJavaScriptEvent
{
    OnUrlChange = 0,
    OnBodyChange = 1,
    OnTitleChange = 2,
    OnButtonPress = 3,
    OnPageLoadStart = 4,
    OnPageLoadEnd = 5,
    OnCustomPost = 6
}

enum WebViewStartMode
{
    Hidden = 0,
    Visible = 1
}

enum WebViewButtonAssetType
{
    DefaultIcon = 0,
    FilePath = 1,
    Base64Data = 2,
    RawData = 3
}

enum WebViewButtonGravity
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
}

// #####################################################################
// # Constructors
// #####################################################################

// #####################################################################
// # Codecs
// #####################################################################

// #####################################################################
// # Functions
// #####################################################################

/**
 * @param {String} _url
 */
function webview_open_url(_url)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _url, type: optional<String>
    if (is_undefined(_url))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_url)) show_error($"{_GMFUNCTION_} :: _url expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_url));
        buffer_write(__args_buffer, buffer_string, _url);
    }

    var _return_value = __webview_open_url(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function webview_hide (no wrapper is required)


// Skipping function webview_show (no wrapper is required)


// Skipping function webview_close (no wrapper is required)


/**
 * @param {String} _html
 */
function webview_load_html(_html)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _html, type: optional<String>
    if (is_undefined(_html))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_html)) show_error($"{_GMFUNCTION_} :: _html expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_html));
        buffer_write(__args_buffer, buffer_string, _html);
    }

    var _return_value = __webview_load_html(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {String} _path
 */
function webview_load_local(_path)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _path, type: optional<String>
    if (is_undefined(_path))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_path)) show_error($"{_GMFUNCTION_} :: _path expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_path));
        buffer_write(__args_buffer, buffer_string, _path);
    }

    var _return_value = __webview_load_local(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function webview_load_blank (no wrapper is required)


/**
 * @param {String} _uid
 */
function webview_load_youtube(_uid)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _uid, type: optional<String>
    if (is_undefined(_uid))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_uid)) show_error($"{_GMFUNCTION_} :: _uid expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_uid));
        buffer_write(__args_buffer, buffer_string, _uid);
    }

    var _return_value = __webview_load_youtube(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function webview_load_no_internet (no wrapper is required)


/**
 * @param {Enum.WebViewStartMode} _mode
 */
function webview_set_start_mode(_mode)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _mode, type: enum WebViewStartMode

    if (!is_numeric(_mode)) show_error($"{_GMFUNCTION_} :: _mode expected number", true);
    buffer_write(__args_buffer, buffer_u8, _mode);

    var _return_value = __webview_set_start_mode(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function webview_set_borderless (no wrapper is required)


// Skipping function webview_get_url (no wrapper is required)


// Skipping function webview_get_title (no wrapper is required)


// Skipping function webview_is_loading (no wrapper is required)


// Skipping function webview_is_running (no wrapper is required)


// Skipping function webview_is_visible (no wrapper is required)


// Skipping function webview_get_body (no wrapper is required)


// Skipping function webview_get_params (no wrapper is required)


// Skipping function webview_allow_swipe_refresh (no wrapper is required)


/**
 * @param {String} _js
 */
function webview_eval_js(_js)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _js, type: optional<String>
    if (is_undefined(_js))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_js)) show_error($"{_GMFUNCTION_} :: _js expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_js));
        buffer_write(__args_buffer, buffer_string, _js);
    }

    var _return_value = __webview_eval_js(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Function} _cb
 */
function webview_set_js_callback(_cb)
{
    static __dispatcher = __GMWebView_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _cb, type: optional<Function>
    if (is_undefined(_cb))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_callable(_cb)) show_error($"{_GMFUNCTION_} :: _cb expected callable type", true);
        var _cb_handle = __ext_core_function_register(_cb, __dispatcher);
        buffer_write(__args_buffer, buffer_u64, _cb_handle);
    }

    var _return_value = __webview_set_js_callback(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Real} _size_dp
 * @param {Real} _gravity
 * @param {Enum.WebViewButtonAssetType} _asset_type
 * @param {String} _asset
 * @returns {Real} 
 */
function webview_button_create(_size_dp, _gravity, _asset_type, _asset)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _size_dp, type: Int32
    if (!is_numeric(_size_dp)) show_error($"{_GMFUNCTION_} :: _size_dp expected number", true);
    buffer_write(__args_buffer, buffer_s32, _size_dp);

    // param: _gravity, type: Int32
    if (!is_numeric(_gravity)) show_error($"{_GMFUNCTION_} :: _gravity expected number", true);
    buffer_write(__args_buffer, buffer_s32, _gravity);

    // param: _asset_type, type: optional<enum WebViewButtonAssetType>
    if (is_undefined(_asset_type))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);

        if (!is_numeric(_asset_type)) show_error($"{_GMFUNCTION_} :: _asset_type expected number", true);
        buffer_write(__args_buffer, buffer_u8, _asset_type);
    }

    // param: _asset, type: optional<String>
    if (is_undefined(_asset))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_asset)) show_error($"{_GMFUNCTION_} :: _asset expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_asset));
        buffer_write(__args_buffer, buffer_string, _asset);
    }

    var _return_value = __webview_button_create(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function webview_button_destroy (no wrapper is required)


// Skipping function webview_button_destroy_all (no wrapper is required)


// Skipping function webview_button_set_alpha (no wrapper is required)


// Skipping function webview_button_set_auto_close (no wrapper is required)


// Skipping function webview_button_set_margins (no wrapper is required)


// Skipping function webview_button_set_size (no wrapper is required)


// Skipping function webview_button_set_gravity (no wrapper is required)


// Skipping function webview_button_set_position (no wrapper is required)


// Skipping function webview_button_set_visible (no wrapper is required)


/**
 * @param {Real} _handle
 * @param {Enum.WebViewButtonAssetType} _asset_type
 * @param {String} _asset
 */
function webview_button_set_asset(_handle, _asset_type, _asset)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _handle, type: Int32
    if (!is_numeric(_handle)) show_error($"{_GMFUNCTION_} :: _handle expected number", true);
    buffer_write(__args_buffer, buffer_s32, _handle);

    // param: _asset_type, type: enum WebViewButtonAssetType

    if (!is_numeric(_asset_type)) show_error($"{_GMFUNCTION_} :: _asset_type expected number", true);
    buffer_write(__args_buffer, buffer_u8, _asset_type);

    // param: _asset, type: optional<String>
    if (is_undefined(_asset))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_string(_asset)) show_error($"{_GMFUNCTION_} :: _asset expected string", true);
        buffer_write(__args_buffer, buffer_u32, string_length(_asset));
        buffer_write(__args_buffer, buffer_string, _asset);
    }

    var _return_value = __webview_button_set_asset(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Real} _handle
 * @param {Function} _callback
 */
function webview_button_set_callback(_handle, _callback)
{
    static __dispatcher = __GMWebView_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _handle, type: Int32
    if (!is_numeric(_handle)) show_error($"{_GMFUNCTION_} :: _handle expected number", true);
    buffer_write(__args_buffer, buffer_s32, _handle);

    // param: _callback, type: optional<Function>
    if (is_undefined(_callback))
    {
        buffer_write(__args_buffer, buffer_bool, false);
    }
    else
    {
        buffer_write(__args_buffer, buffer_bool, true);
        if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
        var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
        buffer_write(__args_buffer, buffer_u64, _callback_handle);
    }

    var _return_value = __webview_button_set_callback(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function webview_shutdown (no wrapper is required)


/// @ignore
function __GMWebView_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMWebView_get_dispatcher()
{
    static __dispatcher = new __GMNativeFunctionDispatcher(__GMWebView_invocation_handler, __GMWebView_get_decoders());
    return __dispatcher;
}
