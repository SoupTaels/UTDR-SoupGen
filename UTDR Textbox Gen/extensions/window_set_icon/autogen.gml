#define window_set_icon_init_raw
/// window_set_icon_init_raw(isRGBA:number)->bool
var _buf = window_set_icon_prepare_buffer(8);
buffer_write(_buf, buffer_f64, argument0);
return window_set_icon_init_raw_raw(buffer_get_address(_buf), 8);

