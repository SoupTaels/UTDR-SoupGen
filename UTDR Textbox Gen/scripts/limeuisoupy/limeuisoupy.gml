///@desc Displays a LimeUI message box accepting arrays for text, blocking ui
///@param {string} textarr_ Text
///@param {string} textbutt_ Text Button
///@param {real} width Width
///@param {real} height Height
///@param {real} padd_ Padding
///@param {Asset.GMSound} snd_ Sound
///@param {Asset.GMFont} font_ Text Font
///@param {function} func_ Function to run
///@param {bool} allowmultiple_ Whether to allow multiple popups
///@param {bool} scribble_ Whether to render text as a Scribble class (performance penalty)
///@param {real} wrap_ Maximum text on a line before a line break
///@param {real} heightb Height Button
function soupy_message(textarr_ = ["Test", "Test 2"], textbutt_ = "OK", width = 620, height = -1, padd_ = 5, snd_ = snd_dimbox, font_ = fnt_determination, func_ = function(){}, allowmultiple_ = false, scribble_ = false, wrap_ = -1, heightb = 35, valign_ = fa_center) {
	window_set_cursor(cr_default);
	if ( !allowmultiple_ && !UI_MESSAGE ) { exit; }
	if ( !is_array(textarr_) ) { textarr_ = string_split(textarr_, "|"); }
	sfx_play(snd_);
	var containter_ = new LuiBox({ x: 0, y: 0, }).centerContent().setPositionAbsolute().bringToFront().setFullSize(); //Fullscreen opaque box
	var panel_ = new LuiPanel({ width, height }); //Container 
	var arr_len =  array_length(textarr_), arr_i = 0, arr_arr = [];
	repeat ( arr_len ) {
		array_push(arr_arr, new LuiText({ value: textarr_[arr_i], auto_width: false, auto_height: false, text_halign: fa_center, text_valign: valign_, font: font_, scribbletext: scribble_, wraplimit: wrap_ }).setPadding(padd_));
	arr_i++; }
	
	array_push(arr_arr, new LuiButton({ text: textbutt_, "height": heightb, font: font_, }).setData("allowmultiple", allowmultiple_).setData("container", containter_).setData("func", func_).setPadding(padd_)
	.addEvent(LUI_EV_CLICK, function (element_) { 
		var allowmultiple = element_.getData("allowmultiple"); SYSTEMUI.ui_paused = allowmultiple;
		var myfunc = element_.getData("func"); myfunc(); 
		var maincan = element_.getData("container"); maincan.destroy(); }));
	panel_.addContent([
		new LuiColumn().setFlexGrow(1).setFlexJustifyContent(flexpanel_justify.flex_end).addContent(arr_arr),
	]);
	SYSTEMUI.soupy_lui.addContent(containter_.addContent(panel_));
	SYSTEMUI.ui_paused = true;
	return containter_;
}

///@desc Displays a LimeUI popup box accepting arrays for LimeUI elements.
///@param {string} elementsarr An array containing elements to be pushed into this popup
///@param {function} func_ Function to run
///@param {string} textbutt_ Text Button
///@param {real} width Width
///@param {real} height Height
///@param {real} padd_ Padding
///@param {Asset.GMSound} snd_ Sound
///@param {Asset.GMFont} font_ Text Font
///@param {bool} allowmultiple_ Whether to allow multiple popups
///@param {real} gap_ Gap
///@param {real} heightb Height Button
function soupy_popup(elementsarr, func_ = function(){}, textbutt_ = "OK", width = 620, height = -1, padd_ = 5, snd_ = snd_dimbox, font_ = fnt_determination, allowmultiple_ = false, gap_ = 5, heightb = 35) {
	window_set_cursor(cr_default);
	if ( !allowmultiple_ && !UI_MESSAGE ) { exit; }
	sfx_play(snd_);
	var containter_ = new LuiBox({ x: 0, y: 0, }).centerContent().setPositionAbsolute().bringToFront().setFullSize(); //Fullscreen opaque box
	var panel_ = new LuiPanel({ width, height }); //Container 
	var arr_arr = elementsarr;	
	array_push(arr_arr, new LuiButton({ text: textbutt_, "height": heightb, font: font_, }).setData("allowmultiple", allowmultiple_).setData("container", containter_).setData("func", func_).setPadding(padd_)
	.addEvent(LUI_EV_CLICK, function (element_) { 
		var allowmultiple_ = element_.getData("allowmultiple"); SYSTEMUI.ui_paused = allowmultiple_;
		var myfunc = element_.getData("func"); myfunc();
		var maincan = element_.getData("container"); maincan.destroy(); }));
	panel_.addContent([
		new LuiColumn().setGap(gap_).setFlexGrow(1).setFlexJustifyContent(flexpanel_justify.flex_end).addContent(arr_arr),
	]);
	SYSTEMUI.soupy_lui.addContent(containter_.addContent(panel_));
	SYSTEMUI.ui_paused = true;
	return containter_;
}

///@desc Open LimeUI color picker
function soupy_color_picker(var_, soupyname_) {
	if ( !soup_store_undefined("colorhistory", true) ) { soup_store("colorhistory", [], , true); }
	soup_store("soupyname", soupyname_);
	soup_store("rgb r", color_get_red(var_)); soup_store("rgb g", color_get_green(var_)); soup_store("rgb b", color_get_blue(var_));
	var clr = new LuiImage({ value: spr_soul, width: 60, height: 48 }).setTooltip("Don't want to use the sliders?\nClick here to open a color picker instead.", true).addEvent(LUI_EV_CREATE, function(element_) { soup_store("element spr", element_); element_.setColor(make_color_rgb(soup_checkout("rgb r", false), soup_checkout("rgb g", false), soup_checkout("rgb b", false))); });
	clr.addEvent(LUI_EV_CLICK, function () { //Open color picker
		sfx_play(snd_bump);
		var result = get_color_ext(c_white, "Pick a new color!"); if ( result < 0 ) { result = c_white; } 
		soup_store("rgb r", color_get_red(result)); soup_store("rgb g", color_get_green(result)); soup_store("rgb b", color_get_blue(result));
		soup_checkout("colormain")(); soup_checkout("colorcan", true, true).destroy(); SYSTEMUI.ui_paused = false; sfx_play(snd_equip2, , , 1.3);
	});
	
	var elemarr = [
		new LuiText({ value: "   <- Your chosen color", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, scale_x: 2, }).addContent(clr),
	
		new LuiSlider({ value: soup_checkout("rgb r", false), min_value: 0, max_value: 255, rounding: true, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, bar_color: c_maroon, bar_color_back: c_maroon, }).setData("clr", clr).addEvent(LUI_EV_VALUE_UPDATE, function(element_) { 
			var getclr = element_.getData("clr"), rgbg = soup_checkout("rgb g", false), rgbb = soup_checkout("rgb b", false);
			soup_store("rgb r", element_.value);
			getclr.setColor(make_color_rgb(soup_checkout("rgb r", false), rgbg, rgbb));
			soup_checkout("element hex", false).set(color_to_hex(soup_checkout("element spr", false).color_blend));
		}).addEvent(LUI_EV_CREATE, function(element_) { soup_store("element r", element_); }),
	
		new LuiSlider({ value: soup_checkout("rgb g", false), min_value: 0, max_value: 255, rounding: true, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, bar_color: c_green, bar_color_back: c_green, }).setData("clr", clr).addEvent(LUI_EV_VALUE_UPDATE, function(element_) { 
			var getclr = element_.getData("clr"), rgbr = soup_checkout("rgb r", false), rgbb = soup_checkout("rgb b", false);
			soup_store("rgb g", element_.value);
			getclr.setColor(make_color_rgb(rgbr, soup_checkout("rgb g", false), rgbb));
			soup_checkout("element hex", false).set(color_to_hex(soup_checkout("element spr", false).color_blend));
		}).addEvent(LUI_EV_CREATE, function(element_) { soup_store("element g", element_); }),
	
		new LuiSlider({ value: soup_checkout("rgb b", false), min_value: 0, max_value: 255, rounding: true, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, bar_color: c_navy, bar_color_back: c_navy, }).setData("clr", clr).addEvent(LUI_EV_VALUE_UPDATE, function(element_) { 
			var getclr = element_.getData("clr"), rgbr = soup_checkout("rgb r", false), rgbg = soup_checkout("rgb g", false);
			soup_store("rgb b", element_.value);
			getclr.setColor(make_color_rgb(rgbr, rgbg, soup_checkout("rgb b", false)));
			soup_checkout("element hex", false).set(color_to_hex(soup_checkout("element spr", false).color_blend));
		}).addEvent(LUI_EV_CREATE, function(element_) { soup_store("element b", element_); }),
	];
	
	#region Color History
		var hist_ = soup_checkout("colorhistory", false, true), hist_len = array_length(hist_), hist_i = 0, hist_clrs = [];
		if ( hist_len > 0 ) {
			repeat ( hist_len ) {
			var cur_ = hist_[hist_i];
				array_push(hist_clrs, new LuiImageButton({ value: spr_pixel, maintain_aspect: false, color: cur_ }).setSize(20, 20)
				.addEvent(LUI_EV_CLICK, function (e_) {
					soup_store("rgb r", color_get_red(e_.color_blend)); soup_store("rgb g", color_get_green(e_.color_blend)); soup_store("rgb b", color_get_blue(e_.color_blend));
					var rgbr = soup_checkout("element r", false); rgbr.value = soup_checkout("rgb r", false); rgbr.update_values();
					var rgbg = soup_checkout("element g", false); rgbg.value = soup_checkout("rgb g", false); rgbg.update_values();
					var rgbb = soup_checkout("element b", false); rgbb.value = soup_checkout("rgb b", false); rgbb.update_values();
					soup_checkout("element spr", false).setColor(make_color_rgb(soup_checkout("rgb r", false), soup_checkout("rgb g", false), soup_checkout("rgb b", false)));
					soup_checkout("element hex", false).set(color_to_hex(soup_checkout("element spr", false).color_blend));
					e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 4); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, -2);
					sfx_play(snd_bump, , , 1.3);
				}) );
			hist_i++; }
		
			array_push(elemarr, new LuiRow().setFlexGrow(1).centerContent().addContent(hist_clrs));
		}
	#endregion
	
	#region Add Default Options
		array_push(elemarr, new LuiRow().setFlexJustifyContent(flexpanel_justify.center).addContent([
			new LuiInput({ height: 40, placeholder: "#RRGGBB", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.alphanumeric, max_length: 6, }).addEvent(LUI_EV_CREATE, function(element_) { soup_store("element hex", element_); }).addEvent(LUI_EV_VALUE_UPDATE, function (e_) {
				var clr = hex_to_color(e_.get());
				soup_store("rgb r", color_get_red(clr)); soup_store("rgb g", color_get_green(clr)); soup_store("rgb b", color_get_blue(clr));
				var rgbr = soup_checkout("element r", false); rgbr.value = soup_checkout("rgb r", false); rgbr.update_values();
				var rgbg = soup_checkout("element g", false); rgbg.value = soup_checkout("rgb g", false); rgbg.update_values();
				var rgbb = soup_checkout("element b", false); rgbb.value = soup_checkout("rgb b", false); rgbb.update_values();
				soup_checkout("element spr", false).setColor(clr);
			}),
			new LuiButton({ text: "RANDOMIZE", "height": 40, }).addEvent(LUI_EV_CLICK, function () {
				soup_store("rgb r", irandom(255)); soup_store("rgb g", irandom(255)); soup_store("rgb b", irandom(255));
				var rgbr = soup_checkout("element r", false); rgbr.value = soup_checkout("rgb r", false); rgbr.update_values();
				var rgbg = soup_checkout("element g", false); rgbg.value = soup_checkout("rgb g", false); rgbg.update_values();
				var rgbb = soup_checkout("element b", false); rgbb.value = soup_checkout("rgb b", false); rgbb.update_values();
				soup_checkout("element spr", false).setColor(make_color_rgb(soup_checkout("rgb r", false), soup_checkout("rgb g", false), soup_checkout("rgb b", false)));
				soup_checkout("element hex", false).set(color_to_hex(soup_checkout("element spr", false).color_blend));
				sfx_play(snd_throw, 0, , 1.5);
			}),
			new LuiButton({ text: "RESET", "height": 40, }).addEvent(LUI_EV_CLICK, function () {
				var def_ = soup_checkout(soup_checkout("soupyname", false), false, true).color_default;
				soup_store("rgb r", color_get_red(def_)); soup_store("rgb g", color_get_green(def_)); soup_store("rgb b", color_get_blue(def_));
				var rgbr = soup_checkout("element r", false); rgbr.value = soup_checkout("rgb r", false); rgbr.update_values();
				var rgbg = soup_checkout("element g", false); rgbg.value = soup_checkout("rgb g", false); rgbg.update_values();
				var rgbb = soup_checkout("element b", false); rgbb.value = soup_checkout("rgb b", false); rgbb.update_values();
				soup_checkout("element spr", false).setColor(make_color_rgb(soup_checkout("rgb r", false), soup_checkout("rgb g", false), soup_checkout("rgb b", false)));
				soup_checkout("element hex", false).set(color_to_hex(soup_checkout("element spr", false).color_blend));
				sfx_play(snd_hurtpowerful);
			}),
		]));
	#endregion
	
	soup_store("colormain", function() { 
		var myobj = soup_checkout(soup_checkout("soupyname"), false, true); 
		myobj.setColor(make_color_rgb(soup_checkout("rgb r"), soup_checkout("rgb g"), soup_checkout("rgb b"))); myobj.set(spr_face_blank);
		var hist_ = soup_checkout("colorhistory", false, true), hist_len = array_length(hist_);
		if ( hist_len < 15 ) { if ( !array_contains(hist_, myobj.color_blend) ) { array_push(hist_, myobj.color_blend); } } else { array_delete(hist_, 0, 1); array_push(hist_, myobj.color_blend); } //Add color to history
		soup_store_clear(); 
	});
	var maincan = soupy_popup(elemarr, soup_checkout("colormain", false), "SET COLOR!"); soup_store("colorcan", maincan, , true);
}
function soupy_color_picker_portrait() { soupy_color_picker(SYSTEMUI.dial_face_clr, "datacolor"); }
function soupy_color_picker_gifcolor() { soupy_color_picker(SYSTEMUI.screenshot_back, "datagifcolor"); }
function soupy_color_picker_border() { soupy_color_picker(SYSTEMUI.bord_clr, "dataimageB"); }
function soupy_color_picker_asterisk() { soupy_color_picker(SYSTEMUI.dial_point_clr, "dataasterisk"); }
function soupy_color_picker_textc() { soupy_color_picker(SYSTEMUI.dial_text_c, "datatextc"); } function soupy_color_picker_textcout() { soupy_color_picker(SYSTEMUI.dial_text_outline, "datatextcout"); }
function soupy_color_picker_shadow() { soupy_color_picker(SYSTEMUI.dial_text_shdw_clr, "datashadow"); }
function soupy_color_picker_shadow_g() { soupy_color_picker(SYSTEMUI.dial_text_shdw_clr_g, "datashadow_g"); }
function soupy_color_picker_gradient() { soupy_color_picker(SYSTEMUI.dial_gradient_clr, "datagradient"); }
function soupy_color_picker_highlight() { soupy_color_picker(SYSTEMUI.dial_highlight, "datahighlight"); }
function soupy_color_picker_underline() { soupy_color_picker(SYSTEMUI.dial_underline, "dataunderline"); }
function soupy_color_picker_striket() { soupy_color_picker(SYSTEMUI.dial_striket, "datastriket"); }
function soupy_color_picker_uicolor() { soupy_color_picker(SYSTEMUI.ui_accentcolor, "datamainuicolor"); }

function soupy_ui_credits() {
	var arr_ = [];
	var credits_add = method({ arr_ }, function(text_ = "", link_ = "", scribble_ = false) {
		array_push(arr_, new LuiText({ scribbletext: scribble_, value: text_, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setData("link", link_).setTooltip(link_, true, fnt_abaddon).setPadding(5)
		.addEvent(LUI_EV_CLICK, function(element_) { var link_ = element_.getData("link"); if ( link_ != "" ) { sfx_play(snd_select); soupy_url(link_, , , 0); } })
		.addEvent(LUI_EV_MOUSE_ENTER, function(element_) { var link_ = element_.getData("link"); if ( link_ != "" ) { element_.color = c_cyan; sfx_play(snd_sel_switch); element_.main_ui.animate(element_, "xoff", 10, 0.30, global.Ease.OutBack, 0); } })
		.addEvent(LUI_EV_MOUSE_LEAVE, function(element_) { element_.color = c_white; element_.main_ui.animate(element_, "xoff", 0, 0.15); }));
	});
	
	var ico_ = get_icon("gameico", "size"); array_push(arr_, new LuiImage({ value: ico_.sprite, }).setFlexAlignSelf(flexpanel_align.center).setSize(ico_.width * 3, ico_.height * 3)); 
	credits_add($"[scale,2]UTDR [c_gold]SoupGen[/c] v{GAME_VERSION}", , true);
	credits_add();
	credits_add("[c_yellow][wobble]Credits:", , true);
	credits_add(".+\\/\\/\\_______________________________________________/\\/\\/+.");
	credits_add();
	credits_add("Scribble, Clean Shapes, Gumshoe: [slant][c_gold]JujuAdams", "https://github.com/JujuAdams", true);
	credits_add("GMLive, ExecuteShellSimple, FileDropper, Taskbar and Icon: [slant][c_gold]YellowAfterlife", "https://yal.cc/", true);
	credits_add("TweenGMX: [slant][c_gold]stephenloney", "https://stephenloney.com/", true);
	credits_add("Undo Stack: [slant][c_gold]alphish-creature(Alice)", "https://github.com/Alphish", true);
	credits_add("LimeUI: [slant][c_gold]Limekys", "https://github.com/Limekys", true);
	credits_add("Quill: [slant][c_gold]RefresherTowelGames", "https://github.com/RefresherTowel", true);
	credits_add("DialogModule, FileManager: [slant][c_gold]Samuel Venable", "https://itch.io/profile/samuel-venable", true);
	credits_add("HTTP.gml: [slant][c_gold]Sidorakh", "https://github.com/Sidorakh", true);
	credits_add("Emobble: [slant][c_gold]tinkerer-red", "https://github.com/tinkerer-red", true);
	credits_add("Android External File Control: [slant][c_gold]Corin Choi", "https://github.com/CorinChoi31/AndroidExternalFile-Extension", true);
	credits_add("Windows Clipboard Functionality: [slant][c_gold]MakhamDev", "https://github.com/Ttanasart-pt/Pixel-Composer", true);
	credits_add("Accurate Determination, Sans, and Papyrus fonts: [slant][c_gold]emihead", "https://twitter.com/emihead", true);
	credits_add("Wing Dings and LEGEND font: [slant][c_gold]Dragon8er", "https://fontstruct.com/fontstructors/1759178/dragon8erd", true);
	credits_add("Undertale, Deltarune: [slant][c_gold]Toby Fox[/] [annoyingdog,0,0.15], [slant][c_gold]Temmie Chang[/] [annoyingtem,0,0.15]", "https://undertale.com/about/", true);
	credits_add("Made in [slant][c_gold]GameMaker[/] [scale,0.15][gamemaker][/]", "https://gamemaker.io/", true);
	credits_add();
	credits_add("[rainbow][wheel]Beta Testers:", , true);
	credits_add(".+\\/\\/\\_______________________________________________/\\/\\/+.");
	credits_add("farfromtile", "https://bsky.app/profile/farfromtile.bsky.social", true);
	credits_add("Ksanthecat", "https://x.com/ksanthecat", true);
	credits_add("Tramon81", "https://tramon81.tumblr.com/", true);
	credits_add("Subna", "https://www.youtube.com/channel/UCQaqTR-zE_iNJMNx36oMOsw", true);
	credits_add("MetaVandetta23", "https://x.com/MetaVandetta23", true);
	credits_add("AxelFrog", "https://bsky.app/profile/did:plc:5umbkrcwww6fsxn3c6et7f5i", true);
	credits_add("noodlescript", "https://bsky.app/profile/did:plc:7esfoz6tuu22avv4m6zxwt25", true);
	credits_add("I'm An Issue", "https://bsky.app/profile/did:plc:tuvvbwiskqxcsjpxoqsv5zpy", true);
	credits_add();
	credits_add(".+\\/\\/\\_______________________________________________/\\/\\/+.");
	credits_add("Huge thanks to [rainbow][wheel]Juju Adams[/][wheel] [scale,0.3][jujugoodpug][/] especially as this wouldn't\nhave been possible without his tools!", , true);
	credits_add();
	credits_add("Happy generating by yours truly, [slant][c_gold]Soup Taels!", "https://souptaels.carrd.co/", true);
	array_push(arr_, new LuiRow().setFlexJustifyContent(flexpanel_justify.center).addContent([
		new LuiImage({ value: spr_soul, color: #ed4577, draw_normal: true, y: 10 }).setSize(20, 16).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 1, 0.15, , 1.3); element_.main_ui.animate(element_, "yscale", 1, 0.15, , 1.3); sfx_play(snd_bump); }),
		new LuiImage({ value: get_icon("tinysoupy"), draw_normal: true, y: 10 }).setSize(19, 19).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 1, 0.15, , 0.5); element_.main_ui.animate(element_, "yscale", 1, 0.15, , 1.5); sfx_play(snd_squish); }),
		new LuiImage({ value: spr_soul, color: #ed4577, draw_normal: true, y: 10 }).setSize(20, 16).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 1, 0.15, , 1.3); element_.main_ui.animate(element_, "yscale", 1, 0.15, , 1.3); sfx_play(snd_bump); }),
	]));

	var maincan = new LuiScrollPanel({ sprite_panel: false, scroll_slider_width: 10, height: 390, }).addContent(arr_);
	soupy_popup([ maincan, ], , "What lovely people!", , 460, , snd_chest, fnt_abaddon, , , 40); //Credits with clickable text links
}

function soupy_ui_textmacros() {
	var arr_ = [];
	
	array_push(arr_, new LuiText({ value: "Macros are reusable text and commands that can be used by doing", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_yellow, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "[macro, (label)] somewhere in the textbox!", truncate: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_yellow, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "Macros are a savable preference, meaning they're all saved on file!", truncate: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_lime, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "Click on a macro to delete it.", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "Right-click to clear the main textbox and edit macro.", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "Want to add a new macro? Add some text to the main textbox,", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "right-click or double-tap, then \"Add as Macro\".",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: ".+\\/\\/\\_______________________________________________/\\/\\/+.",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	
	var hist_ = struct_get_names(global.pref.macros), hist_len = array_length(hist_), hist_i = 0;
	if ( hist_len > 0 ) {
		repeat ( hist_len ) {
		var cur_ = hist_[hist_i];
			array_push(arr_, new LuiText({ value: cur_, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setTooltip(global.pref.macros[$ cur_], true, , true, 600).setPadding(5)
			.addEvent(LUI_EV_CLICK, function(element_) { var label_ = element_.get(); if ( is_android() ) { clipboard_set_text(global.pref.macros[$ label_]); } struct_remove(global.pref.macros, label_); SYSTEMUI.save_pref(); sfx_play(snd_throw); SYSTEMUI.ui_paused = false; soup_checkout("mainui", , true).destroy(); })
			.addEvent(LUI_EV_CLICK_R, function(element_) { 
				SYSTEMUI.textinput.SetValue(global.pref.macros[$ element_.get()]); SYSTEMUI.dial_updatet = 1; 
				struct_remove(global.pref.macros, element_.get()); SYSTEMUI.save_pref(); sfx_play(snd_equip);
				SYSTEMUI.ui_paused = false; SYSTEMUI.ui_tab = 0; on_reset_(false); soup_checkout("mainui", , true).destroy(); })
			.addEvent(LUI_EV_MOUSE_ENTER, function(element_) { element_.color = c_red; sfx_play(snd_sel_switch); element_.main_ui.animate(element_, "xoff", 10, 0.30, global.Ease.OutBack, 0); })
			.addEvent(LUI_EV_MOUSE_LEAVE, function(element_) { element_.color = c_white; element_.main_ui.animate(element_, "xoff", 0, 0.15); }));
		hist_i++; }
	}
	else {
		array_push(arr_, new LuiText({ value: "(No macros found.)", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_gray, xoff: 0, y: 10 }));
	}
	
	var maincan = new LuiScrollPanel({ sprite_panel: false, scroll_slider_width: 10, height: 390, }).addContent(arr_);
	var mainui = soupy_popup([ maincan, ], , "Go Back", , 460, , snd_chest, fnt_abaddon, , , 40); soup_store("mainui", mainui, , true);
}
	
function soupy_ui_presets() {
	var arr_ = [];
	
	array_push(arr_, new LuiText({ value: "Config presets allow you to save/ load common settings", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_yellow, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "so that you don't always have to go through the menuing", truncate: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_yellow, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "process for a particular look again!", truncate: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_yellow, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: ".+\\/\\/\\_______________________________________________/\\/\\/+.",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiButton({ text: "Save Current Settings", height: 35, })
		.addEvent(LUI_EV_CLICK, function (e_) {
			var arr_ = [
				new LuiText({ value: "Labels must be uniquely named.", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }),
				new LuiInput({ height: 40, placeholder: "Label (ex: uty_clover, wavyrainbow, soupytext, etc.)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("label", e_, , true); }),
				new LuiButton({ text: "Add new preset!", height: 40, }).addEvent(LUI_EV_CLICK, function () { 
					var result = soup_checkout("label", false, true).get();
					if ( string_trim(string_lettersdigits(result)) == "" ) { soupy_message("You cannot have a|blank or invalid label.", , 270, , , snd_error, , , true); exit; }
				
					var available = is_undefined(global.pref.presets[$ result]);
					if ( available ) { sfx_play(snd_sparkle2); sfx_play(snd_chest); SYSTEMUI.save_preset(result); SYSTEMUI.save_pref(); soup_checkout("mainui2", , true).destroy(); SYSTEMUI.ui_paused = false; soup_checkout("mainui", , true).destroy(); }
					else { soupy_message("A preset with this|label already exists.", , 270, , , snd_error, , , true); }
				}),
			];
		
			var mainui = soupy_popup(arr_, , "Cancel", , , , snd_dimbox, fnt_abaddon, true); soup_store("mainui2", mainui, , true);
		})
	);
	array_push(arr_, new LuiText({ value: ".+\\/\\/\\_______________________________________________/\\/\\/+.",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(0).setHeight(5));
	
	var hist_ = struct_get_names(global.pref.presets), hist_len = array_length(hist_), hist_i = 0;
	if ( hist_len > 0 ) {
		repeat ( hist_len ) {
			var cur_ = hist_[hist_i];
			var preset_arr = [
				new LuiText({ value: cur_, text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10 }).setPadding(5),
				new LuiButton({ text: "APPLY", height: 35, width: 80, }).setData("name", cur_).setData("data", global.pref.presets[$ cur_])
				.addEvent(LUI_EV_CLICK, function (e_) {
					var data = e_.getData("data"), data_i = 0, data_var = struct_get_names(data), data_len = array_length(data_var);
					repeat ( data_len ) {
						var data_cur = data_var[data_i];
						variable_instance_set(obj_system, data_cur, data[$ data_cur]);
					data_i++; }
					with ( SYSTEMUI ) { typist.in(typist_spd, typist_smooth); typist.ease(typist_ease.type, typist_ease.x, typist_ease.y, typist_ease.xscale, typist_ease.yscale, typist_ease.angle, typist_ease.alpha); ui_paused = false; }
					sfx_play(snd_equip2); soup_checkout("mainui", , true).destroy(); 
				}),
				new LuiButton({ text: "DISCARD", height: 35, width: 80, }).setData("name", cur_).setData("data", global.pref.presets[$ cur_])
				.addEvent(LUI_EV_CLICK, function (e_) { struct_remove(global.pref.presets, e_.getData("name")); SYSTEMUI.save_pref(); sfx_play(snd_throw); SYSTEMUI.ui_paused = false; soup_checkout("mainui", , true).destroy(); }),
			];
		
			array_push(arr_, new LuiRow().setFlexGrow(1).centerContent().addContent(preset_arr));
		hist_i++; }
	}
	else {
		array_push(arr_, new LuiText({ value: "(No presets found.)", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_gray, xoff: 0, y: 10 }));
	}
	
	var maincan = new LuiScrollPanel({ sprite_panel: false, scroll_slider_width: 10, height: 390, }).addContent(arr_);
	var mainui = soupy_popup([ maincan, ], , "Go Back", , 460, , snd_chest, fnt_abaddon, , , 40); soup_store("mainui", mainui, , true);
}
	
function soupy_ui_icons() {
	var arr_ = [], i = 0, icons_ = struct_get_names(global.icons_dict_alt), len = array_length(icons_);
	
	#region Info Text
		var sort = 0;
		array_push(arr_, new LuiText({ value: "View all the lovely icons SoupGen provides",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: "as well as your own provided icons!",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: ".+\\/\\/\\_______________________________________________/\\/\\/+.",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: "Select an icon to copy its sprite command to your clipboard.",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: "The command will be formatted as so:",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: "[sprite name, image frame, animation speed]",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: ".+\\/\\/\\_______________________________________________/\\/\\/+.",text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
		array_push(arr_, new LuiText({ value: "", text_halign: fa_center, text_valign: fa_middle, font: fnt_abaddon, color: c_white, xoff: 0, y: 10, truncate: false, }).setPadding(0).setHeight(5).setData("name", sort++));
	#endregion
	
	#region Add Icons
		repeat ( len ) {
			var cur = icons_[i];
			var ico_ = get_icon(cur);
			array_push(arr_, new LuiImageButton({ value: ico_, draw_normal: true, height: sprite_get_height(ico_), }).setData("name", cur).setTooltip($"{cur}\nFrames: {sprite_get_number(ico_)}", true, fnt_abaddon)
				.addEvent(LUI_EV_MOUSE_ENTER, function(element_) { element_.imgspd = 0.30; sfx_play(snd_sel_switch); element_.main_ui.animate(element_, "xoff", 10, 0.30, global.Ease.OutBack, 0); })
				.addEvent(LUI_EV_MOUSE_LEAVE, function(element_) { element_.imgspd = 0; element_.main_ui.animate(element_, "xoff", 0, 0.15); })
				.addEvent(LUI_EV_CLICK, function(element_) { var name = element_.getData("name"); clipboard_set_text($"[{name},0,0]"); })
			);
		i++; }
	#endregion
	
	#region Sort Names Alphabetically
		array_sort(arr_, function(arrcur_, arrnext_) {
			if ( string_lower(arrcur_.getData("name")) < string_lower(arrnext_.getData("name")) ) { return -1; }
			else if ( string_lower(arrcur_.getData("name")) > string_lower(arrnext_.getData("name")) ) { return 1; }
			else { return 0; }
		});
	#endregion
	
	var maincan = new LuiScrollPanel({ sprite_panel: false, scroll_slider_width: 10, height: 390, }).addContent(arr_);
	var mainui = soupy_popup([ maincan, ], , "Go Back", , 460, , snd_chest, fnt_abaddon, , , 40); soup_store("mainui", mainui, , true);
}
	
function soupy_ui_success(fname, gif_ = false, fpath_final) {
	var arr_ = [
		new LuiText({ value: $"{fname}_.{gif_ ? "gif" : "png"}[/] [rainbow][wave]saved at", auto_width: true, auto_height: true, text_halign: fa_center, text_valign: fa_center, font: fnt_abaddon, scribbletext: true, wraplimit: 590 }).setPadding(15),
		new LuiText({ value: $"[c_lime]{fpath_final}!", auto_width: true, auto_height: true, text_halign: fa_center, text_valign: fa_center, font: fnt_abaddon, scribbletext: true, wraplimit: 590 }).setPadding(15),
		new LuiText({ value: "Your [c_gold]good soup[/] is hot and ready!", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_center, font: fnt_abaddon, scribbletext: true, wraplimit: 590 }).setPadding(10),
		new LuiText({ value: $"The { is_wasm() ? "Data URI" : "file path" } was [c_yellow]copied to your clipboard.", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_center, font: fnt_abaddon, scribbletext: true, wraplimit: 590 }).setPadding(10),
		new LuiText({ value: $"{ global.pref.openresult ? "The result will open up in your [c_cyan][slant]default image viewer and file browser." : "" }", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_center, font: fnt_abaddon, scribbletext: true, wraplimit: 590 }).setPadding(10),
		new LuiText({ value: "Please share your dialogue with [c_gold]#soupgen[/] for easier find!", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_center, font: fnt_abaddon, scribbletext: true, wraplimit: 590 }).setPadding(10),
		new LuiButton({ text: "I don't see it.", "height": 35, font: fnt_abaddon, }).setTooltip(!is_wasm() ? "Don't see where your file is located?\nLet's try to upload your result to\na temp file hosting server instead!\nIt will expire in 1 hour." : "", true).setData("file", fpath_final).addEvent(LUI_EV_CLICK, function (e_) {
			if ( !is_wasm() ) { 
				var form = new FormData(); form.add_file("file", e_.getData("file")); form.add_data("expire", "3600");
				http("https://tmpfiles.org/api/v1/upload", "POST", form, , function(_, result) { sfx_play(snd_dimbox); soupy_url(result.data.url, , , , false); clipboard_set_text(result.data.url); }, function (_, result) { soupy_message("[shake][c_red]An error had occurred.[/]||Either the hosting server([c_gray][slant]uguu.se[/]) is down|or your internet is down.", "Uh oh.", 400, , , snd_error, fnt_abaddon, , true, true); });
			}
			else {
				soupy_message("The export should've opened an new tab that shows an image.|If you don't see anything, try refreshing that tab!|If that doesn't work, then paste the Data URI that was copied to your clipboard|(if you're not on Firefox) into the address bar.", "I see.", , , , snd_equip, fnt_abaddon, function () { get_string_async("Copy the Data URI, then paste it into the address bar.", soup_checkout("datauri", false, true)); }, true, true);
			}
		}),
	];
	soupy_popup(arr_, , "I'm so soupy!!", 620, , , snd_dumbvictory, fnt_abaddon, );
}