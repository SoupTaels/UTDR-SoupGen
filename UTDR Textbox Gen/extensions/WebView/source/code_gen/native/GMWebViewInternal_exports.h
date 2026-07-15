// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#include "core/GMExtUtils.h"

// Internal function used for fetching dispatched function calls to GML
GMEXPORT double __EXT_NATIVE__GMWebView_invocation_handler(char* __ret_buffer, double __ret_buffer_length);

GMEXPORT double __EXT_NATIVE__webview_open_url(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_hide();
GMEXPORT double __EXT_NATIVE__webview_show();
GMEXPORT double __EXT_NATIVE__webview_close();
GMEXPORT double __EXT_NATIVE__webview_load_html(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_load_local(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_load_blank();
GMEXPORT double __EXT_NATIVE__webview_load_youtube(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_load_no_internet();
GMEXPORT double __EXT_NATIVE__webview_set_start_mode(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_set_borderless(double on);
GMEXPORT char* __EXT_NATIVE__webview_get_url();
GMEXPORT char* __EXT_NATIVE__webview_get_title();
GMEXPORT double __EXT_NATIVE__webview_is_loading();
GMEXPORT double __EXT_NATIVE__webview_is_running();
GMEXPORT double __EXT_NATIVE__webview_is_visible();
GMEXPORT char* __EXT_NATIVE__webview_get_body();
GMEXPORT char* __EXT_NATIVE__webview_get_params();
GMEXPORT double __EXT_NATIVE__webview_allow_swipe_refresh(double allow);
GMEXPORT double __EXT_NATIVE__webview_eval_js(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_set_js_callback(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_button_create(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_button_destroy(double handle);
GMEXPORT double __EXT_NATIVE__webview_button_destroy_all();
GMEXPORT double __EXT_NATIVE__webview_button_set_alpha(double handle, double alpha);
GMEXPORT double __EXT_NATIVE__webview_button_set_auto_close(double handle, double flag);
GMEXPORT double __EXT_NATIVE__webview_button_set_margins(double handle, double left, double top, double right, double bottom);
GMEXPORT double __EXT_NATIVE__webview_button_set_size(double handle, double size_dp);
GMEXPORT double __EXT_NATIVE__webview_button_set_gravity(double handle, double gravity);
GMEXPORT double __EXT_NATIVE__webview_button_set_position(double handle, double x_dp, double y_dp);
GMEXPORT double __EXT_NATIVE__webview_button_set_visible(double handle, double visible);
GMEXPORT double __EXT_NATIVE__webview_button_set_asset(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_button_set_callback(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__webview_shutdown();

