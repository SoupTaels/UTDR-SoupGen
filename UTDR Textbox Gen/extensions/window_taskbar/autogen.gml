#define window_progress
/// window_progress(status:int, current:int = 0, total:int = 0)->bool
var _buf = window_taskbar_prepare_buffer(30);
buffer_write(_buf, buffer_u64, int64(window_handle()));
buffer_write(_buf, buffer_s32, argument[0]);
if (argument_count >= 2) {
	buffer_write(_buf, buffer_bool, true);
	buffer_write(_buf, buffer_u64, argument[1]);
} else buffer_write(_buf, buffer_bool, false);
if (argument_count >= 3) {
	buffer_write(_buf, buffer_bool, true);
	buffer_write(_buf, buffer_u64, argument[2]);
} else buffer_write(_buf, buffer_bool, false);
return window_progress_raw(buffer_get_address(_buf), 30);

#define window_flash
/// window_flash(flags:int, count:int = 0, freq:int = 0)->bool
var _buf = window_taskbar_prepare_buffer(22);
buffer_write(_buf, buffer_u64, int64(window_handle()));
buffer_write(_buf, buffer_s32, argument[0]);
if (argument_count >= 2) {
	buffer_write(_buf, buffer_bool, true);
	buffer_write(_buf, buffer_u32, argument[1]);
} else buffer_write(_buf, buffer_bool, false);
if (argument_count >= 3) {
	buffer_write(_buf, buffer_bool, true);
	buffer_write(_buf, buffer_u32, argument[2]);
} else buffer_write(_buf, buffer_bool, false);
return window_flash_raw(buffer_get_address(_buf), 22);

