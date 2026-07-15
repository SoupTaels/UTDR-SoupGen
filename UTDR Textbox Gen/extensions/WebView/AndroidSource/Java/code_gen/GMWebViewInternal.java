// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public abstract class GMWebViewInternal extends RunnerSocial implements GMWebViewInterface {

    private final GMExtWire.DispatchQueue __dispatch_queue = new GMExtWire.DispatchQueue();
    public double __EXT_NATIVE__GMWebView_invocation_handler(ByteBuffer __ret_buffer, double __ret_buffer_length)
    {
        return __dispatch_queue.fetch(__ret_buffer);
    }

    public double __EXT_NATIVE__webview_open_url(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: url, type: optional<String>
        java.util.Optional<String> url = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_url = GMExtWire.readString(__arg_buffer);
            url = java.util.Optional.of(__opt_url);
        }

        webview_open_url(url);
        return 0;
    }

    public double __EXT_NATIVE__webview_hide()
    {
        webview_hide();
        return 0;
    }

    public double __EXT_NATIVE__webview_show()
    {
        webview_show();
        return 0;
    }

    public double __EXT_NATIVE__webview_close()
    {
        webview_close();
        return 0;
    }

    public double __EXT_NATIVE__webview_load_html(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: html, type: optional<String>
        java.util.Optional<String> html = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_html = GMExtWire.readString(__arg_buffer);
            html = java.util.Optional.of(__opt_html);
        }

        webview_load_html(html);
        return 0;
    }

    public double __EXT_NATIVE__webview_load_local(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: path, type: optional<String>
        java.util.Optional<String> path = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_path = GMExtWire.readString(__arg_buffer);
            path = java.util.Optional.of(__opt_path);
        }

        webview_load_local(path);
        return 0;
    }

    public double __EXT_NATIVE__webview_load_blank()
    {
        webview_load_blank();
        return 0;
    }

    public double __EXT_NATIVE__webview_load_youtube(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: uid, type: optional<String>
        java.util.Optional<String> uid = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_uid = GMExtWire.readString(__arg_buffer);
            uid = java.util.Optional.of(__opt_uid);
        }

        webview_load_youtube(uid);
        return 0;
    }

    public double __EXT_NATIVE__webview_load_no_internet()
    {
        webview_load_no_internet();
        return 0;
    }

    public double __EXT_NATIVE__webview_set_start_mode(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: mode, type: enum WebViewStartMode
        WebViewStartMode mode = WebViewStartMode.from(GMExtWire.readI8(__arg_buffer));

        webview_set_start_mode(mode);
        return 0;
    }

    public double __EXT_NATIVE__webview_set_borderless(double on)
    {
        webview_set_borderless(on != 0);
        return 0;
    }

    public String __EXT_NATIVE__webview_get_url()
    {
        String __result = webview_get_url();
        return __result;
    }

    public String __EXT_NATIVE__webview_get_title()
    {
        String __result = webview_get_title();
        return __result;
    }

    public double __EXT_NATIVE__webview_is_loading()
    {
        boolean __result = webview_is_loading();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__webview_is_running()
    {
        boolean __result = webview_is_running();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__webview_is_visible()
    {
        boolean __result = webview_is_visible();
        return __result ? 1.0 : 0.0;
    }

    public String __EXT_NATIVE__webview_get_body()
    {
        String __result = webview_get_body();
        return __result;
    }

    public String __EXT_NATIVE__webview_get_params()
    {
        String __result = webview_get_params();
        return __result;
    }

    public double __EXT_NATIVE__webview_allow_swipe_refresh(double allow)
    {
        webview_allow_swipe_refresh(allow != 0);
        return 0;
    }

    public double __EXT_NATIVE__webview_eval_js(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: js, type: optional<String>
        java.util.Optional<String> js = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_js = GMExtWire.readString(__arg_buffer);
            js = java.util.Optional.of(__opt_js);
        }

        webview_eval_js(js);
        return 0;
    }

    public double __EXT_NATIVE__webview_set_js_callback(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: cb, type: optional<Function>
        java.util.Optional<GMFunction> cb = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            GMFunction __opt_cb = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);
            cb = java.util.Optional.of(__opt_cb);
        }

        webview_set_js_callback(cb);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_create(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: size_dp, type: Int32
        int size_dp = GMExtWire.readI32(__arg_buffer);

        // field: gravity, type: Int32
        int gravity = GMExtWire.readI32(__arg_buffer);

        // field: asset_type, type: optional<enum WebViewButtonAssetType>
        java.util.Optional<WebViewButtonAssetType> asset_type = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            WebViewButtonAssetType __opt_asset_type = WebViewButtonAssetType.from(GMExtWire.readI8(__arg_buffer));
            asset_type = java.util.Optional.of(__opt_asset_type);
        }

        // field: asset, type: optional<String>
        java.util.Optional<String> asset = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_asset = GMExtWire.readString(__arg_buffer);
            asset = java.util.Optional.of(__opt_asset);
        }

        int __result = webview_button_create(size_dp, gravity, asset_type, asset);
        return (double)__result;
    }

    public double __EXT_NATIVE__webview_button_destroy(double handle)
    {
        webview_button_destroy((int)handle);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_destroy_all()
    {
        webview_button_destroy_all();
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_alpha(double handle, double alpha)
    {
        webview_button_set_alpha((int)handle, (double)alpha);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_auto_close(double handle, double flag)
    {
        webview_button_set_auto_close((int)handle, flag != 0);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_margins(double handle, double left, double top, double right, double bottom)
    {
        webview_button_set_margins((int)handle, (int)left, (int)top, (int)right, (int)bottom);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_size(double handle, double size_dp)
    {
        webview_button_set_size((int)handle, (int)size_dp);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_gravity(double handle, double gravity)
    {
        webview_button_set_gravity((int)handle, (int)gravity);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_position(double handle, double x_dp, double y_dp)
    {
        webview_button_set_position((int)handle, (int)x_dp, (int)y_dp);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_visible(double handle, double visible)
    {
        webview_button_set_visible((int)handle, visible != 0);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_asset(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: handle, type: Int32
        int handle = GMExtWire.readI32(__arg_buffer);

        // field: asset_type, type: enum WebViewButtonAssetType
        WebViewButtonAssetType asset_type = WebViewButtonAssetType.from(GMExtWire.readI8(__arg_buffer));

        // field: asset, type: optional<String>
        java.util.Optional<String> asset = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            String __opt_asset = GMExtWire.readString(__arg_buffer);
            asset = java.util.Optional.of(__opt_asset);
        }

        webview_button_set_asset(handle, asset_type, asset);
        return 0;
    }

    public double __EXT_NATIVE__webview_button_set_callback(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: handle, type: Int32
        int handle = GMExtWire.readI32(__arg_buffer);

        // field: callback, type: optional<Function>
        java.util.Optional<GMFunction> callback = java.util.Optional.empty();
        if (GMExtWire.readBool(__arg_buffer))
        {
            GMFunction __opt_callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);
            callback = java.util.Optional.of(__opt_callback);
        }

        webview_button_set_callback(handle, callback);
        return 0;
    }

    public double __EXT_NATIVE__webview_shutdown()
    {
        webview_shutdown();
        return 0;
    }

}