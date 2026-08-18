///@desc WASM Android
var result = async_load;
if ( result[? "id"] == soup_checkout("keywasm", , true) ) { 
	if ( is_undefined(soup_checkout("wasmtype", false, true)) ) { //We're dealing with the main textbox
		sfx_play(snd_txttype);
		textinput.SetValue(result[? "result"]);
		textinput.Blur();
		dial_updatet = 1;
		soup_checkout("wasmtype", , true);
	}
	else {
		sfx_play(snd_txttype);
		var lime = soup_checkout("wasmtype", , true);
		lime.set(result[? "result"]);
		time_source_stop(lime.cursor_timer);
        lime.cursor_pointer = "";
        lime.main_ui.waiting_for_keyboard_input = false;
		lime.has_focus = false;
	}
}