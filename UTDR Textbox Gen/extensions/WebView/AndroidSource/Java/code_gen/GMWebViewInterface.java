// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

import java.util.Optional;

public interface GMWebViewInterface {
    public void webview_open_url(java.util.Optional<String> url);
    public void webview_hide();
    public void webview_show();
    public void webview_close();
    public void webview_load_html(java.util.Optional<String> html);
    public void webview_load_local(java.util.Optional<String> path);
    public void webview_load_blank();
    public void webview_load_youtube(java.util.Optional<String> uid);
    public void webview_load_no_internet();
    public void webview_set_start_mode(WebViewStartMode mode);
    public void webview_set_borderless(boolean on);
    public String webview_get_url();
    public String webview_get_title();
    public boolean webview_is_loading();
    public boolean webview_is_running();
    public boolean webview_is_visible();
    public String webview_get_body();
    public String webview_get_params();
    public void webview_allow_swipe_refresh(boolean allow);
    public void webview_eval_js(java.util.Optional<String> js);
    public void webview_set_js_callback(java.util.Optional<GMFunction> cb);
    public int webview_button_create(int size_dp, int gravity, java.util.Optional<WebViewButtonAssetType> asset_type, java.util.Optional<String> asset);
    public void webview_button_destroy(int handle);
    public void webview_button_destroy_all();
    public void webview_button_set_alpha(int handle, double alpha);
    public void webview_button_set_auto_close(int handle, boolean flag);
    public void webview_button_set_margins(int handle, int left, int top, int right, int bottom);
    public void webview_button_set_size(int handle, int size_dp);
    public void webview_button_set_gravity(int handle, int gravity);
    public void webview_button_set_position(int handle, int x_dp, int y_dp);
    public void webview_button_set_visible(int handle, boolean visible);
    public void webview_button_set_asset(int handle, WebViewButtonAssetType asset_type, java.util.Optional<String> asset);
    public void webview_button_set_callback(int handle, java.util.Optional<GMFunction> callback);
    public void webview_shutdown();
}