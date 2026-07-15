package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.enums.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import android.app.Activity;
import java.util.*;

public class GMWebView extends GMWebViewInternal {

    final GMWebViewManager manager = GMWebViewManager.get();

    public GMWebView() {
        super();
        Activity activity = RunnerActivity.CurrentActivity;        
        manager.init(activity, false);
    }

    public void webview_open_url(java.util.Optional<String> url) {
        manager.openUrl(url.orElse(""));
    }

    public void webview_hide() {
        manager.hide();
    }

    public void webview_show() {
        manager.show();
    }

    public void webview_close() {
        manager.close();
    }

    public void webview_load_html(java.util.Optional<String> html) {
        manager.loadHtml(html.orElse(""));
    }

    public void webview_load_local(java.util.Optional<String> path) {
        manager.loadLocal(path.orElse(""));
    }

    public void webview_load_blank() {
        manager.loadBlank();
    }

    public void webview_load_youtube(java.util.Optional<String> uid) {
        manager.loadYouTube(uid.orElse(""));
    }

    public void webview_load_no_internet() {
        manager.loadNoInternet();
    }

    public void webview_set_start_mode(WebViewStartMode mode) {
    }

    public void webview_set_borderless(boolean on) {
    }

    public String webview_get_url() {
        return manager.getUrl();
    }

    public String webview_get_title() {
        return manager.getTitle();
    }

    public boolean webview_is_loading() {
        return manager.isLoading();
    }

    public boolean webview_is_running() {
        return manager.isRunning();
    }

    public boolean webview_is_visible() {
        return manager.isVisible();
    }

    public String webview_get_body() {
        return manager.getBody();
    }

    public String webview_get_params() {
        return manager.getParams();
    }

    public void webview_allow_swipe_refresh(boolean allow) {
        manager.allowSwipeRefresh(allow);
    }

    public void webview_eval_js(java.util.Optional<String> js) {
        manager.evalJS(js.orElse(""));
    }

    public void webview_set_js_callback(java.util.Optional<GMFunction> cb) {
        manager.setJSCallback(cb.orElse(null));
    }

    public void webview_open_external(java.util.Optional<String> url) {
        manager.openExternal(url.orElse(""));
    }

    public int webview_button_create(int size_dp, int gravity, java.util.Optional<WebViewButtonAssetType> asset_type, java.util.Optional<String> asset_path) {
        return manager.buttonCreate(size_dp, gravity, asset_type.orElse(WebViewButtonAssetType.DefaultIcon).value(), asset_path.orElse(""));
    }

    public void webview_button_destroy(int handle) {
        manager.buttonDestroy(handle);
    }

    public void webview_button_destroy_all() {
        manager.buttonDestroyAll();
    }

    public void webview_button_set_alpha(int handle, double alpha) {
        manager.buttonSetAlpha(handle, alpha);
    }

    public void webview_button_set_auto_close(int handle, boolean flag) {
        manager.buttonSetAutoClose(handle, flag);
    }

    public void webview_button_set_margins(int handle, int left, int top, int right, int bottom) {
        manager.buttonSetMargins(handle, left, top, right, bottom);
    }

    public void webview_button_set_size(int handle, int size_dp) {
        manager.buttonSetSize(handle, size_dp);
    }

    public void webview_button_set_gravity(int handle, int gravity) {
        manager.buttonSetGravity(handle, gravity);
    }

    public void webview_button_set_position(int handle, int x_dp, int y_dp) {
        manager.buttonSetPosition(handle, x_dp, y_dp);
    }

    public void webview_button_set_visible(int handle, boolean visible) {
        if (visible) manager.buttonShow(handle);
        else manager.buttonHide(handle);
    }

    public void webview_button_set_asset(int handle, WebViewButtonAssetType asset_type, java.util.Optional<String> asset) {
        manager.buttonSetAsset(handle, asset_type.value(), asset.orElse(null));
    }

    public void webview_button_set_callback(int handle, java.util.Optional<GMFunction> callback) {
        manager.buttonSetCallback(handle, callback.orElse(null));
    }
    
    public void webview_shutdown() {
        manager.close();
    }

}