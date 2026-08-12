///@desc 3D BG
#region BG

	if ( ui_visible && global.pref.bg3d && !sprite_exists(global.refimg) ) {
		var bg = layer_exists("bg3d") ? layer_get_id("bg3d") : layer_create(99, "bg3d"), _fx = layer_get_fx("bg3d"), _params; //Doesn't exist? Create it! Else, get the id.
		if ( _fx == -1 ) { //Doesn't exist? Create it with default values
			_fx = fx_create("_filter_parallax");
			_params = fx_get_parameters(_fx);
			_params.g_ParallaxDirection = [0, 0.54];
			_params.g_ParallaxPerspective = 1;
			_params.g_ParallaxPosition = [0, 1, 0];
			_params.g_ParallaxScale = 0.5;
			_params.g_ParallaxDepth = 0;
			_params.g_ParallaxFogColour = [0, 0, 0, 1];
			_params.g_ParallaxFogRange = [0, 40];
			_params.g_ParallaxFogDepth = 0;
			_params.g_ParallaxTexture = spr_testbg;
			fx_set_parameters(_fx,_params);
		}

		_params = fx_get_parameters(_fx);
		_params.g_ParallaxPosition[0] -= .02;
		_params.g_ParallaxPosition[2] -= .01;
		fx_set_parameters(_fx,_params);
		layer_set_fx("bg3d",_fx);
	}
	else { if ( layer_exists("bg3d") ) { layer_destroy("bg3d"); } }
	
	if ( mouse_pressed && ui_viewing ) { ui_unviewref(); }
#endregion

#region Windows Taskbar
	if ( is_android() ) { exit; }
	
	if ( screenshot_stacked || ( record.enabled && record.type == 1 ) ) { window_progress(ui_preview ? window_progress_paused : window_progress_normal, dial_text_page + 1, dial_text_page_c); }
	else if ( record.enabled && record.type == 0 ) { window_progress(ui_preview ? window_progress_paused : window_progress_normal, record.frames, record.framesmax); }
#endregion

#region WASM
	if ( file_exists("soupysprite.png") ) {
		var ref_ = soup_checkout("wasmimport", , true);
		switch ( ref_ ) {
			case "reference": {
				global.refimg = sprite_add_ext("soupysprite.png", 1, 0, 0, true);
				sfx_play(snd_updated); ui_refclr = c_white; TweenFire("?", SYSTEMUI, "$30", "+60", TPCol("ui_refclr>"), $15101c);
				if ( !global.pref.sizematters ) { global.pref.sizematters = true; sfx_play(snd_bump, , , 1.3); }
				file_delete("soupysprite.png");
			} break;
			
			case "face": case "border": case "font": {
				var once_ = soup_checkout("once");
				if ( is_undefined(once_) ) {
					soup_store("once");
					soup_store("wasmimportuisprite", sprite_add("soupysprite.png", 0, 0, 0, 0, 0)); //Store new sprite
					var sprite_ = soup_store_ensure("wasmimportuisprite", -1), height_ = sprite_get_height(sprite_); //Get new sprite and save reference
					sprite_set_offset(sprite_, sprite_get_width(sprite_)/ 2, height_/ 2); //Center new sprite
					
					var arr_ = [
						new LuiText({ value: "This is your chosen sprite:", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, }),
						new LuiImage({ value: sprite_, height: height_ > 200 ? 200 : height_, draw_normal: height_ > 200 ? false : true, }),
						new LuiText({ value: "You will need to give it a nickname:", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, }),
						new LuiText({ value: "(If this is a strip sprite, add \"_strip#\" at the end. Don't include \".png\")", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_gray, }),
						new LuiInput({ placeholder: "uty_clover, jasper_strip2, testguy_strip5, etc.", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_CREATE, function (e_) { soup_store("wasmimportname", e_); }).setPadding(20),
					];
					soupy_popup(arr_, function () {
						sprite_delete(soup_checkout("wasmimportuisprite")); //Delete new sprite
						
						var name_ = soup_checkout("wasmimportname").get(); //Get the nickname
						if ( string_trim(string_lettersdigits(name_)) == "" ) { soupy_message("You cannot have a|blank or invalid label.", , 270, , , snd_error, , , true); file_delete("soupysprite.png"); soup_checkout("once"); exit; }
						
						var result = $"{name_}.png";
						var myname_ = string_exclude(string_replace(string_replace(filename_name(result), "_strip", ""), ".png", ""), "0123456789"); 
						external_ensure(myname_, filename_name(result), "soupysprite.png", soup_checkout("wasmimporttype", , true), !SYSTEMUI.ui_paused);
					
						file_delete("soupysprite.png"); //Delete file reference
						soup_checkout("datafunc", false)(); //Destroy face chooser ui
						soup_checkout("once");
					}, "Let's get soupy!!", , , , snd_dimbox, fnt_abaddon, ui_paused);
				}
			} break;
		}
	}
#endregion