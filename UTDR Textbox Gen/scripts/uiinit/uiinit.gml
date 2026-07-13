function ui_init() {
	#region Engine UI
		fader = 1; TweenFire("$10", "fader>", 0); //Black overlay
		ui_accentcolor = global.pref.randomclr ? make_color_hsv(irandom(255), irandom_range(150, 230), 255) : global.pref.themeclr;
		ui_tab = 0; //Current Tab (0 - Dialogue, 1 - Face, 2 - Border, 3 - About)
		screenshot = false; //Screenshot task
		screenshot_stacked = false; //Whether dialogue exports are stacked
		screenshot_surf = -1; //Screenshot surface
		screenshot_back = global.pref.gifbgclr; //Color for GIF background clearing
		record = { enabled: false, type: 0, frames: 0, framesmax: 0, id_: -1, quant: 1, delay: 60, }; //Whether to record, the type of recording(0 - static, 1 - wait for dialogue to finish), and how long to record for
		ui_visible = true; //Whether the UI should be visible
		ui_effoff = 0; //Effects array offset 
		ui_tab_yoff = 0; //Y offset for the orange and white borders
		ui_paused = false; //Whether to freeze ui elements
		file_dragging = false; //Whether a file is being dragged on screen.
		file_newname = ""; //New name for the file
		ui_mainfont = fnt_speech;
		ui_refclr = $15101c; //Reference image color
		ui_viewing = false; //Whether we're looking at the reference image
		ui_finished = false; //Whether we finished recording the GIF
		ui_finished_y = -100; //UI animation
		ui_preview = false; //Whether we're previewing animated dialogue
		if ( !is_android() ) { var tinysoup = "icons\\tinysoupy.png"; if ( file_exists(tinysoup) ) { widget_set_icon(tinysoup); } file_dropper_init(); }
		undo_stack_create(); //History of undo changes
		scribble_font_set_default("fnt_determination_nomono");
		instance_create_depth(0, 0, -2, obj_updatechecker);
	
		#region Main Menu Buttons
			var i = 0, spr_ = spr_border_octagon, x_ = 320, y_ = 12, clr_ = ui_accentcolor, padd_ = 14;
			butt[i] = new Button({ id_: i, text: "Dialogue [spr_gui_icons,0]", x: x_, y: y_, yoff: 0, padd_multi: padd_, sprite: spr_, color_butt: clr_, color: clr_, on_hover: -1, on_enter: -1, on_leave: -1, on_click: -1, centered: false, });
			with ( butt[i++].data ) { self[$ "on_hover"] = method(self, on_hover_); self[$ "on_enter"] = method(self, on_enter_); self[$ "on_leave"] = method(self, on_leave_); self[$ "on_click"] = method(self, on_click_); }
			butt[i] = new Button({ id_: i, text: "Style        [spr_gui_icons,4]", x: x_, y: y_, yoff: 0, padd_multi: padd_, sprite: spr_, color_butt: clr_, color: clr_, on_hover: -1, on_enter: -1, on_leave: -1, on_click: -1, centered: false, });
			with ( butt[i++].data ) { self[$ "on_hover"] = method(self, on_hover_); self[$ "on_enter"] = method(self, on_enter_); self[$ "on_leave"] = method(self, on_leave_); self[$ "on_click"] = method(self, on_click_); }
			butt[i] = new Button({ id_: i, text: "Portrait [spr_gui_icons,1]", x: x_, y: y_, yoff: 0, padd_multi: padd_, sprite: spr_, color_butt: clr_, color: clr_, on_hover: -1, on_enter: -1, on_leave: -1, on_click: -1, centered: false, });
			with ( butt[i++].data ) { self[$ "on_hover"] = method(self, on_hover_); self[$ "on_enter"] = method(self, on_enter_); self[$ "on_leave"] = method(self, on_leave_); self[$ "on_click"] = method(self, on_click_); }
			butt[i] = new Button({ id_: i, text: "Border      [spr_gui_icons,2]", x: x_, y: y_, yoff: 0, padd_multi: padd_, sprite: spr_, color_butt: clr_, color: clr_, on_hover: -1, on_enter: -1, on_leave: -1, on_click: -1, centered: false, });
			with ( butt[i++].data ) { self[$ "on_hover"] = method(self, on_hover_); self[$ "on_enter"] = method(self, on_enter_); self[$ "on_leave"] = method(self, on_leave_); self[$ "on_click"] = method(self, on_click_); }
			butt[i] = new Button({ id_: i, text: "Extras      [spr_gui_icons,3]", x: x_, y: y_, yoff: 0, padd_multi: padd_, sprite: spr_, color_butt: clr_, color: clr_, on_hover: -1, on_enter: -1, on_leave: -1, on_click: -1, centered: false, });
			with ( butt[i++].data ) { self[$ "on_hover"] = method(self, on_hover_); self[$ "on_enter"] = method(self, on_enter_); self[$ "on_leave"] = method(self, on_leave_); self[$ "on_click"] = method(self, on_click_); }
		
			if ( is_android() ) {
				butt[i] = new Button({ id_: i, text: "[rainbow]Export[/rainbow]      [spr_gui_icons,6]", x: x_, y: y_, yoff: 0, padd_multi: padd_, sprite: spr_, color_butt: c_white, color: c_white, on_hover: -1, on_enter: -1, on_leave: -1, on_click: -1, centered: false, });
				with ( butt[i++].data ) { self[$ "on_hover"] = method(self, on_hover_); self[$ "on_enter"] = method(self, on_enter_a); self[$ "on_leave"] = method(self, on_leave_); self[$ "on_click"] = function () { soup_store("androidexport", , , true); } }
			}
			call_later(1, time_source_units_frames, on_reset_); //Reset all buttons on start
			call_later(1, time_source_units_frames, function() { if ( !is_android() ) { window_progress(window_progress_none); } });
		#endregion

		#region Textbox
			quill_change = false; //QuillMulti()
			textinput = QuillMulti(, "(Click here to start typing!)\n(Your raw text input lives here. Processed output is below.)\n(Click on the quick buttons above to quickly insert text\n colors and effects. Try highlighting portions of texts!)\n(All done? Just press ESC for export options!)\n(Want a background for your exports? Add a reference image\n in the Extras tab!)\n \n   (Happy generating and make sure to eat some good soup!!)")
				.SetInputMode(QUILL_TEXTMODE_TEXT).SetWrap(false).AllowActions(false).SetResizable(false).SetUseOverlayEditor(false)
				.SetTabInserts(true).SetTabUsesSpaces(false).SetTabSpaces(4)
				.SetCaretBlink(false).SetCaretFade(true).SetCaretFadeTime(250).SetCaretRepeatRate(10)
				.OnBlur(function() { //Theme for inactivity
					var quill_soup_inactive = new QuillTheme();
					quill_soup_inactive.textbox.text_col = #9d8cbb; quill_soup_inactive.textbox.placeholder_col = #9d8cbb; quill_soup_inactive.textbox.line_highlight_a = 0;
					quill_soup_inactive.skins.prim_bg_idle_col = #524271; quill_soup_inactive.skins.prim_bg_active_col = #292138; quill_soup_inactive.skins.prim_bg_hover_col = #625279; quill_soup_inactive.skins.prim_border_thickness = 0;
					quill_soup_inactive.scrollbar.border_col = #9d8cbb; quill_soup_inactive.scrollbar.border_a = 1; quill_soup_inactive.scrollbar.track_col = #9d8cbb; quill_soup_inactive.scrollbar.track_a = 1; quill_soup_inactive.scrollbar.thumb_idle_col = #d6b5dd; quill_soup_inactive.scrollbar.thumb_idle_a = 1;
					quill_soup_inactive.fonts.mainfont = SYSTEMUI.ui_mainfont;
					QuillSetTheme(quill_soup_inactive);
					keyboard_virtual_hide();
				})
				.OnFocus(function() { //Theme for activity
					var quill_soup_active = new QuillTheme();
					quill_soup_active.textbox.text_col = c_white; quill_soup_active.textbox.placeholder_col = #9d8cbb; quill_soup_active.textbox.line_highlight_col = #503f6e;
					quill_soup_active.skins.prim_bg_idle_col = #524271; quill_soup_active.skins.prim_bg_active_col = #292138; quill_soup_active.skins.prim_bg_hover_col = #625279; quill_soup_active.skins.prim_border_thickness = 0;
					quill_soup_active.scrollbar.thumb_active_col = #9a89b8; quill_soup_active.scrollbar.thumb_active_a = 1; quill_soup_active.scrollbar.track_col = #503f6e; quill_soup_active.scrollbar.track_a = 1; quill_soup_active.scrollbar.border_col = #503f6e; quill_soup_active.scrollbar.border_a = 1;
					quill_soup_active.selection.bg_col = #d6b5dd; 
					quill_soup_active.menu.item_hover_col = #9d8cbb; quill_soup_active.menu.bg_spr = spr_border_undertale; quill_soup_active.menu.prim_bg_col = c_white; quill_soup_active.menu.prim_bg_a = 1; quill_soup_active.menu.prim_border_col = c_black; quill_soup_active.menu.text_col = c_white; quill_soup_active.menu.sep_col = #9d8cbb; quill_soup_active.menu.disabled_text_col = #625279; quill_soup_active.menu.sep_h = 3; quill_soup_active.menu.pad_x = 10; quill_soup_active.menu.pad_y = 20; quill_soup_active.menu.item_hover_a = 1; quill_soup_active.menu.prim_padd = 2; quill_soup_active.menu.min_w = 200;
					quill_soup_active.fonts.mainfont = SYSTEMUI.ui_mainfont;
					QuillSetTheme(quill_soup_active);
					keyboard_string = "";
					keyboard_virtual_show(kbv_type_default, kbv_returnkey_next, kbv_autocapitalize_none, false);
				})
			
				#region Context Menu
					textinput.ContextMenuAddItem(QuillContextMenuItem("Copy", method(self, function () { //Copy text to clipboard
						var txt_ = textinput.GetSelection(), result = string_copy_at(textinput.GetValue(), txt_.start + 1, txt_._end + 1) ;
						if ( clipboard_get_text() != result ) { clipboard_set_text(result); sfx_play(snd_equip); } else { sfx_play(snd_cancel); }
					}), "soupy_copy").SetShortcut("Ctrl+C"))
					.ContextMenuAddItem(QuillContextMenuItem("Cut", method(self, function () { //Copy text to clipboard, then delete text
						var txt_ = textinput.GetSelection(), result = string_copy_at(textinput.GetValue(), txt_.start + 1, txt_._end + 1), finalresult = string_delete_at(textinput.GetValue(), txt_.start + 1, txt_._end + 1);
						clipboard_set_text(result); sfx_play(snd_throw); textinput.SetValue(finalresult); dial_updatet = 1; textinput.SetCaret(txt_.start);
					}), "soupy_cut").SetShortcut("Ctrl+X"))
					.ContextMenuAddItem(QuillContextMenuItem("Paste", method(self, function () { //Paste text from clipboard
						var caret_ = textinput.GetCaret(), txt_ = textinput.GetValue(), select_ = textinput.GetSelection();
						if ( !select_.has_selection ) { //Paste text
							var result = string_insert(clipboard_get_text(), txt_, caret_ + 1);
							sfx_play(snd_bump);
						}
						else { //Delete selection, then paste text
							var remove_ = string_delete_at(txt_, select_.start + 1, select_._end + 1);
							var result = string_insert(clipboard_get_text(), remove_, caret_ + 1);
							sfx_play(snd_enc1);
						}
						textinput.SetValue(result); dial_updatet = 1; textinput.SetCaret(caret_);
					}), "soupy_paste").SetShortcut("Ctrl+V"))
					.ContextMenuAddItem(QuillContextMenuSeparator())
					.ContextMenuAddItem(QuillContextMenuItem("Select All", method(self, function () { textinput.SelectAll(); sfx_play(snd_enc1); }), "soupy_select").SetShortcut("Ctrl+A"))
					.ContextMenuAddItem(QuillContextMenuItem("Clear All", method(self, soupy_context_clear), "soupy_clear").SetShortcut("Ctrl+S"))
					.ContextMenuAddItem(QuillContextMenuItem("Undo", method(self, undo_stack_undo), "soupy_undo").SetShortcut("Ctrl+Z"))
					.ContextMenuAddItem(QuillContextMenuItem("Redo", method(self, undo_stack_redo), "soupy_redo").SetShortcut("Shift+Ctrl+Z"))
					.ContextMenuAddItem(QuillContextMenuSeparator())
					.ContextMenuAddItem(QuillContextMenuItem("Insert Page", method(self, soupy_context_page), "soupy_page").SetShortcut("Ctrl+D"))
					.ContextMenuAddItem(QuillContextMenuItem("Add As Macro", method(self, soupy_context_macro), "soupy_macro").SetShortcut("Ctrl+P"))
					.on_blur();
				#endregion
		#endregion
	#endregion

	#region Menu Sections
		#region Init Style
			var soupy_style = new LuiStyle({ padding: 15, gap: 10, color_text: c_white, color_hover: c_yellow, sound_click: snd_select, sound_hover: snd_sel_switch, }) //Main Style
				.setRenderRegionOffset([10, 10, 10, 10])
				.setFonts(fnt_determination, fnt_determination, fnt_determination).setColors(, ui_accentcolor, #f43e83, #15ee97)
				.setSprites(spr_border_undertale_outlined, spr_border_undertale_outlined).setSpriteCheckbox(spr_border_undertale_outlined, spr_pixel).setSpriteComboBoxArrow(spr_soul_tiny)
			soupy_lui = new LuiMain().setStyle(soupy_style);
		#endregion
		
		#region Portrait Panel
			var x1_ = 10, y1_ = 45, x2_ = 600, y2_ = 385, w_ = x2_ - x1_, h_ = y2_ - y1_;
			soupy_panel_portrait = new LuiScrollPanel({ x: 10, y: 45, width: w_, height: h_, scroll_pin_edge_offset:10, sprite_panel: false, sound_right: snd_throw, }); //Start containter
		
				var panel_base_ = { text: "", color: ui_accentcolor, sprite_button: spr_border_header, height: 40, font: fnt_speech, text_color: c_black, sound_click: snd_enc1, sound_click_pitch: 1.3, };
				var panel_ = new LuiContainer().setPadding(0).addContent([
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a sprite
						new LuiText({ value: "Sprite:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the portrait sprite.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[face,character,expression][/]\nor [c_yellow][[face,filename][/]. Set to [c_red]-1[/] for no\ndialogue portrait.", true, , true),
						new LuiButton({ text: "Choose...", height: 40, width: 100, }).addEvent(LUI_EV_CLICK, external_choose_face),
						new LuiInput({ height: 40, placeholder: "or type. (ex: spr_face_test)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datainput", e_, , true); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var spr_ = soup_checkout("dataimage", false, true), getface = get_face(e_.get()); 
							spr_.set(getface == -1 ? spr_gui_icons : getface); spr_.subimg = ( getface == -1 ? 3 : 0 );
							FACE_CURRENT = getface; FACE_INTERNAL = e_.get(); if ( getface != -1 ) { sfx_play(snd_updated); }
						}),
						new LuiImage({ draw_normal: true, }).setSize(70, 70).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataimage", e_, , true); }).addEvent(LUI_EV_SHOW, function(e_) { 
							var input_ = soup_checkout("datainput", false, true), spr_ = soup_checkout("dataimage", false, true);
							spr_.set(FACE_CURRENT == -1 ? spr_gui_icons : FACE_CURRENT).setSubimg(FACE_CURRENT == -1 ? 3 : 0).setColor(SYSTEMUI.dial_face_clr);
							input_.set(FACE_CURRENT == -1 ? "" : FACE_INTERNAL); 
						}).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 1, 0.15, , 0.7); element_.main_ui.animate(element_, "yscale", 1, 0.15, , 1.3); sfx_play(snd_squish); })
						   .addEvent(LUI_EV_CLICK_R, function(element_) {
								var input_ = soup_checkout("datainput", false, true), spr_ = soup_checkout("dataimage", false, true);
								if ( spr_.get() != spr_gui_icons && input_.get() != "" ) { spr_.set(spr_gui_icons).setSubimg(3).setColor(SYSTEMUI.dial_face_clr); input_.set(""); sfx_play(snd_hurtpowerful); }
							}),
					]),
					
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image index
						new LuiText({ value: "Image Index:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the image number of the\ncurrent dialogue portrait displaying.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[face_index,#][/].\n[c_yellow][slant]Sync With Dialogue[/] will be switched [c_red]off[/].", true, , true),
						new LuiInput({ height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.numbers, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(FACE_CURRENT != -1 ? FACE_INDEX : 0); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							if ( dial_text_gif ) { exit; }
							var spr_ = soup_checkout("dataimage", false, true), value_ = e_.get(), index_ = real(value_ == "" ? 0 : value_);
							if ( spr_.get() != spr_gui_icons ) { spr_.setSubimg(index_); FACE_INDEX = index_; }
							if ( dial_face_auto && soup_checkout("triggered") != undefined ) { dial_face_auto = false; }
						}).addEvent(LUI_EV_CLICK, function(e_) { soup_store("triggered"); }),
					]),
					
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image speed
						new LuiText({ value: "Image Speed:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the animation speed of the\ncurrent dialogue portrait displaying.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[face_speed,#][/].\n[c_yellow][slant]Sync With Dialogue[/] will be switched [c_red]off[/].", true, , true),
						new LuiInput({ height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(FACE_CURRENT != -1 ? FACE_SPEED : 0); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							if ( dial_text_gif ) { exit; }
							var spr_ = soup_checkout("dataimage", false, true), value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_;
							if ( spr_.get() != spr_gui_icons ) { spr_.imgspd = index_; FACE_SPEED = index_; }
							if ( dial_face_auto && soup_checkout("triggered") != undefined ) { dial_face_auto = false; }
						}).addEvent(LUI_EV_CLICK, function(e_) { soup_store("triggered"); }),
					]),
				]);
				var panel_header_ = new LuiButton(panel_base_).setText("Current Face Settings").setTooltip("These settings only affect the dialogue\nportrait on the [wave][c_cyan]current highlighted page.", true, , true).setData("header", panel_).setIcon(spr_gui_icons,,, c_black,, 1).addEvent(LUI_EV_CLICK, function(e_) { var header = e_.getData("header"); header.toggleVisible(); }); soupy_panel_portrait.addContent([panel_header_, panel_, ]); //End container
				
				var panel_ = new LuiContainer().setPadding(0).addContent([
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image index
						new LuiText({ value: "Talk Speed:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes how often portraits animate\nbased on how many letters needs to\nbe revealed.", true, , true),
						new LuiInput({ value: dial_face_anim, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.numbers, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(floor(SYSTEMUI.dial_face_anim)); })
						.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var result = e_.get(); SYSTEMUI.dial_face_anim = real(result == "" ? 2 : result); }),
					]),
				
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
						new LuiText({ value: "Color:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of every dialogue portrait.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[effect,color,R,G,B,time]", true, , true),
						new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_portrait),
						new LuiImage({ value: spr_face_test, draw_normal: true, }).setSize(70, 70).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datacolor", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 1, 0.15, , 0.7); element_.main_ui.animate(element_, "yscale", 1, 0.15, , 1.3); sfx_play(snd_squish); })
						.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.dial_face_clr = e_.color_blend; e_.set(spr_face_test); soup_checkout("dataimage", false, true).setColor(e_.color_blend); audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_white ) { exit; } e_.main_ui.animate(e_, "xscale", 1, 0.15, , 0.7); e_.main_ui.animate(e_, "yscale", 1, 0.15, , 1.3); e_.setColor(c_white); soup_checkout("dataimage", false, true).setColor(c_white); SYSTEMUI.dial_face_clr = c_white; sfx_play(snd_hurtpowerful); }),
					]),
					
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
						new LuiText({ value: "Scale:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the scale of every dialogue portrait.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[effect,scale,X,Y,frames,issmooth]", true, , true),
						new LuiInput({ value: "2", height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).bindVariable(self, "dial_face_xscale").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var get_ = e_.get(), value_ = real_ext(get_ == "" ? 2 : get_), index_ = value_ == "" ? 2 : value_; SYSTEMUI.dial_face_xscale = index_; SYSTEMUI.dial_face_yscale = index_;
						}),
					]),
					
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image angle
						new LuiText({ value: "Angle:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the angle of every dialogue portrait.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[effect,rotate,#,frames,issmooth]", true, , true),
						new LuiSlider({ min_value: 0, color_text: c_black, color_text_drag: c_white, max_value: 360, rounding: true, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_face_angle); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var value_ = real(e_.get()); SYSTEMUI.dial_face_angle = value_; SYSTEMUI.dial_face_angle_orig = SYSTEMUI.dial_face_angle; soup_checkout("dataimage", false, true).angle = value_;
						}),
					]),
					
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image alpha
						new LuiText({ value: "Opacity:", width: 85, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the alpha of every dialogue portrait.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[effect,fade,#,frames]", true, , true),
						new LuiSlider({ value: dial_face_alpha, min_value: 0, color_text: c_black, color_text_drag: c_white, max_value: 1, rounding: false, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_face_alpha); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var value_ = real(e_.get()); SYSTEMUI.dial_face_alpha = value_; SYSTEMUI.dial_face_alpha_orig = SYSTEMUI.dial_face_alpha; soup_checkout("dataimage", false, true).angle = value_;
						}),
					]),
				
					new LuiRow().setFlexGrow(1).centerContent().addContent([ 
						new LuiText({ value: "X Off:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the X position for\nevery dialogue portrait.", true, , true),
						new LuiInput({ value: dial_face_xoff_static, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).bindVariable(self, "dial_face_xoff_static").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var get_ = e_.get(), value_ = real_ext(get_ == "" ? 0 : get_), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_face_xoff_static = index_; SYSTEMUI.dial_face_xoff_static_orig = index_;
						}),
					]),
				
					new LuiRow().setFlexGrow(1).centerContent().addContent([ 
						new LuiText({ value: "Y Off:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the Y position for\nevery dialogue portrait.", true, , true),
						new LuiInput({ value: dial_face_yoff_static, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).bindVariable(self, "dial_face_yoff_static").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var get_ = e_.get(), value_ = real_ext(get_ == "" ? 0 : get_), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_face_yoff_static = index_; SYSTEMUI.dial_face_yoff_static_orig = index_;
						}),
					]),
					
					new LuiHorizontalRule({ height: 5, }),
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Animate with dialogue
						new LuiText({ value: "Sync with dialogue:", width: 185, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether to animate the face while\ndialogue is typing out.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[face_auto,\"true\" or \"false\"]", true, , true),
						new LuiToggleSwitch({ value: dial_face_auto, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_face_auto"),
					]),
					
					new LuiRow().setFlexGrow(1).centerContent().addContent([ //Keep original dialogue face
						new LuiText({ value: "Keep previous face:", width: 185, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether to always keep the last dialogue face\nor reset back to the original face.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[face_orig,character,expression]", true, , true),
						new LuiToggleSwitch({ value: dial_face_keep, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_face_keep"),
					]),
				
					new LuiRow().setFlexGrow(1).centerContent().addContent([
						new LuiText({ value: "Name Tag:", text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Adds a tiny name tag onto the border.\nLeave blank for no name tag.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[nametag,string]", true, , true),
						new LuiInput({ value: dial_nametag, height: 40, placeholder: "Toriel, Susie, etc.(accepts effect & color commands)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).bindVariable(self, "dial_nametag")
					]),
				]);
				var panel_header_ = new LuiButton(panel_base_).setText("Global Face Settings").setTooltip("These settings affect [wave][c_red]all[/] dialogue portraits.", true, , true).setData("header", panel_).setIcon(spr_gui_icons,,, c_black,, 5).addEvent(LUI_EV_CLICK, function(e_) { var header = e_.getData("header"); header.toggleVisible(); }); soupy_panel_portrait.addContent([panel_header_, panel_, ]); //End container
		
			soupy_lui.addContent(soupy_panel_portrait); //Add everything to the main ui
		#endregion
		
		#region Border Panel
			var x1_ = 10, y1_ = 45, x2_ = 600, y2_ = 385, w_ = x2_ - x1_, h_ = y2_ - y1_;
			soupy_panel_border = new LuiScrollPanel({ x: 10, y: 45, width: w_, height: h_, scroll_pin_edge_offset:10, sprite_panel: false, sound_right: snd_throw, }) //Start containter
			.addContent([
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a sprite
					new LuiText({ value: "Sprite:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the border sprite.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[border,sprite name][/].", true, , true),
					new LuiButton({ text: "Choose...", height: 40, width: 100, }).addEvent(LUI_EV_CLICK, external_choose_border),
					new LuiInput({ value: sprite_get_name(SYSTEMUI.spr_bord), height: 40, placeholder: "or type. (ex: spr_border_deltarune)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datainputB", e_, , true); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var spr_ = soup_checkout("dataimageB", false, true), getface = get_border(e_.get()); 
						spr_.set(getface == -1 ? spr_border_undertale : getface); spr_.subimg = SYSTEMUI.bord_index;
						SYSTEMUI.spr_bord = (getface == -1 ? spr_border_undertale : getface); SYSTEMUI.bord_prev = SYSTEMUI.spr_bord; bord_name = (getface == -1 ? "spr_border_undertale" : e_.get()); if ( getface != -1 ) { sfx_play(snd_updated); }
					}),
					new LuiImage({ value: SYSTEMUI.spr_bord, maintain_aspect: false, xscale: 0, yscale: 0, }).setSize(70, 70).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataimageB", e_, , true); e_.bounce = SYSTEMUI.bord_anim; }).addEvent(LUI_EV_SHOW, function(e_) { 
						var input_ = soup_checkout("datainputB", false, true);
						e_.set(SYSTEMUI.spr_bord).setSubimg(SYSTEMUI.bord_index).setColor(SYSTEMUI.bord_clr);
						input_.set(bord_name); 
					}).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 0.15, , 5); element_.main_ui.animate(element_, "yscale", 0, 0.15, , 5); sfx_play(snd_squish); })
					   .addEvent(LUI_EV_VALUE_UPDATE, function(e_) { audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); TweenScript(SYSTEMUI, 0, 2, function() { var e_ = soup_checkout("dataimageB", false, true); e_.set(SYSTEMUI.spr_bord); }); SYSTEMUI.bord_clr = e_.color_blend; }).addEvent(LUI_EV_CLICK_R, function(e_) {
						var input_ = soup_checkout("datainputB", false, true); SYSTEMUI.spr_bord = spr_border_undertale; SYSTEMUI.bord_prev = SYSTEMUI.spr_bord;
						input_.set("spr_border_undertale"); audio_stop_sound(snd_updated); sfx_play(snd_hurtpowerful); e_.main_ui.animate(e_, "xscale", 0, 0.15, , 5); e_.main_ui.animate(e_, "yscale", 0, 0.15, , 5); e_.setColor(c_white); SYSTEMUI.bord_clr = c_white;
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Color:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the dialogue border.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[fx,colorborder,r,g,b,frames][/].", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_border),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image index
					new LuiText({ value: "Image Index:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the image number of the\ndialogue border.", true, , true),
					new LuiInput({ value: bord_index, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.numbers, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(floor(SYSTEMUI.bord_index)); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var result = e_.get(); SYSTEMUI.bord_index = real(result == "" ? 0 : result);
						soup_checkout("dataimageB", false, true).setSubimg(SYSTEMUI.bord_index);
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image speed
					new LuiText({ value: "Image Speed:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the animation speed of the\ndialogue border.", true, , true),
					new LuiInput({ value: bord_spd, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.bord_spd); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var spr_ = soup_checkout("dataimageB", false, true), value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; spr_.imgspd = index_; SYSTEMUI.bord_spd = index_;
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
					new LuiText({ value: "Scale:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the scale of dialogue borders.\nOnly applies to [c_yellow]custom dialogue borders[/].", true, , true),
					new LuiInput({ value: bord_scale, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.bord_scale); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var spr_ = soup_checkout("dataimageB", false, true), value_ = real_ext(e_.get()), index_ = value_ == "" ? 2 : value_; SYSTEMUI.bord_scale = index_;
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Nine slice
					new LuiText({ value: "Nine Stretch:", width: 120, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether [c_yellow]custom borders[/] should stretch\nto fill space instead of tiling.\n[c_red]Not applicable[/] for [c_yellow][slant]arbitrary borders[/].", true, , true),
					new LuiToggleSwitch({ value: bord_stretch, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "bord_stretch"),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Animation bounce back
					new LuiText({ value: "Bounce Back:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether dialogue borders should reverse its\nanimation once their animation ends.", true, , true),
					new LuiToggleSwitch({ value: bord_anim, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "bord_anim").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { soup_checkout("dataimageB", false, true).bounce = e_.get(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Visbility
					new LuiText({ value: "Visible:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }),
					new LuiToggleSwitch({ value: bord_anim, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "bord_box_visible").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { soup_checkout("dataimageB", false, true).setAlpha(e_.get()); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Arbitrary Border:", width: 160, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether to allow borders of [slant]any\narbitrary size and customization[/].\nThis means [c_red]nineslice is disabled[/] and\nyou'll need to provide a border sprite\nof exact size. This will also enable\n[c_yellow]Bigger Resolution[/].\nJust make sure your border isn't cluttering\nUI elements or else [shake]you won't be able to see!", true, , true),
					new LuiToggleSwitch({ value: global.pref.anyborder, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "anyborder").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.bord_scale = e_.get() ? 1 : 2; global.pref.sizematters = true; SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
					new LuiText({ value: "Text X Off:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Offset dialogue text on the x axis.\nEspecially useful for [c_yellow][slant]arbitrary borders[/].", true, , true),
					new LuiInput({ value: dial_text_xoff, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_text_xoff); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_text_xoff = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
					new LuiText({ value: "Text Y Off:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Offset dialogue text on the y axis.\nEspecially useful for [c_yellow][slant]arbitrary borders[/].", true, , true),
					new LuiInput({ value: dial_text_yoff, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_text_yoff); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_text_yoff = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
					new LuiText({ value: "Border X Off:", width: 150, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Offset [c_yellow][slant]arbitrary borders[/] on the x axis.", true, , true),
					new LuiInput({ value: bord_xoff, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.bord_xoff); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.bord_xoff = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
					new LuiText({ value: "Border Y Off:", width: 150, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Offset [c_yellow][slant]arbitrary borders[/] on the y axis.", true, , true),
					new LuiInput({ value: bord_yoff, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.bord_yoff); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.bord_yoff = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image angle
					new LuiText({ value: "Border Angle:", width: 150, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Change the rotation of [c_yellow][slant]arbitrary borders[/].", true, , true),
					new LuiSlider({ min_value: 0, color_text: c_black, color_text_drag: c_white, max_value: 360, rounding: true, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, }).bindVariable(self, "bord_angle").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						//var value_ = real(e_.get()); SYSTEMUI.bord_angle = value_;
					}),
				]),
			]);
		
			soupy_lui.addContent(soupy_panel_border); //Add everything to the main ui
		#endregion
		
		#region Style Panel
			var x1_ = 10, y1_ = 45, x2_ = 600, y2_ = 385, w_ = x2_ - x1_, h_ = y2_ - y1_;
			soupy_panel_style = new LuiScrollPanel({ x: 10, y: 45, width: w_, height: h_, scroll_pin_edge_offset:10, sprite_panel: false, sound_right: snd_throw, }) //Start containter
			.addContent([
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a sprite
					new LuiText({ value: "Font:", width: 65, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the dialogue font.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[font name](ex: [[fnt_sans])[/].", true, , true),
					new LuiButton({ text: "Choose...", height: 40, width: 100, }).addEvent(LUI_EV_CLICK, external_choose_font),
					new LuiInput({ value: dial_font, height: 40, placeholder: "or type. (ex: fnt_determination)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datainputS", e_, , true); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var prev_ = soup_checkout("datafont", false, true), value = e_.get(); prev_.font = scribble_font_exists(value) ? value : "fnt_determination";
						SYSTEMUI.dial_font = prev_.font; audio_stop_sound(snd_updated); sfx_play(snd_updated);
					}),
					new LuiText({ value: "AaBbCc", width: 100, text_halign: fa_center, text_valign: fa_middle, font: dial_font, scribbletext: true, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datafont", e_, , true); })
					.addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "yoff", 0, 1, global.Ease.OutElastic, 10); sfx_play(snd_squish); })
					.addEvent(LUI_EV_CLICK_R, function(element_) {
						var input_ = soup_checkout("datainputS", false, true), spr_ = soup_checkout("datafont", false, true);
						if ( spr_.font != "fnt_determination" && input_.get() != "" ) { spr_.font = "fnt_determination"; input_.set(""); sfx_play(snd_hurtpowerful); audio_stop_sound(snd_updated); }
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Text Color:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the text.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[color name][/].", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_textc),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_text_c }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datatextc", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_text_c = e_.color_blend; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_white ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_white); SYSTEMUI.dial_text_c = c_white; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Outline Color:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the text outline.\nRight-click to remove outline.", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_textcout),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_text_outline }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datatextcout", e_, , true); }).addEvent(LUI_EV_SHOW, function(e_) { e_.setColor(SYSTEMUI.dial_text_outline); })
					.addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_text_outline = e_.color_blend; if ( !string_search(SYSTEMUI.dial_font, "_outline", true) ) { SYSTEMUI.dial_font = $"{SYSTEMUI.dial_font}_outline"; } audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == -1 ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(-1); SYSTEMUI.dial_text_outline = -1; SYSTEMUI.dial_font = string_replace(SYSTEMUI.dial_font, "_outline", ""); sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text Scale:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the scale of dialogue text.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[scale,#][/].", true, , true),
					new LuiInput({ value: dial_text_scale, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_text_scale); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 2 : value_; SYSTEMUI.dial_text_scale = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text Speed:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the typewriter's text speed.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[speed,#][/].", true, , true),
					new LuiInput({ value: typist_spd, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.typist_spd); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0.5 : value_; SYSTEMUI.typist_spd = index_; SYSTEMUI.typist_spd_orig = SYSTEMUI.typist_spd; typist.in(SYSTEMUI.typist_spd, SYSTEMUI.typist_smooth); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text HAlign:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the dialogue's horizontal alignment.\n[c_yellow]0[/] - Left, [c_yellow]1[/] - Center, [c_yellow]2[/] - Right\n[c_red]This will disable [c_yellow]auto-asterisk[/].", true, , true),
					new LuiInput({ height: 40, placeholder: "0 - Left, 1 - Center, 2 - Right", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.numbers, max_length: 1, }).bindVariable(self, "dial_text_halign")
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { soup_checkout("dataalignh", false, true).setSubimg(real(e_.get() == "" ? "0" : e_.get())); dial_text_halign = real(e_.get() == "" ? "0" : e_.get()); }),
					new LuiImage({ value: spr_gui_alignment_h, maintain_aspect: false }).setSize(32, 32).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataalignh", e_, , true); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text VAlign:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the dialogue's vertical alignment.\n[c_yellow]0[/] - Top, [c_yellow]1[/] - Middle, [c_yellow]2[/] - Bottom\n[c_red]This will disable [c_yellow]auto-asterisk[/].", true, , true),
					new LuiInput({ height: 40, placeholder: "0 - Top, 1 - Middle, 2 - Bottom", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.numbers, max_length: 1, }).bindVariable(self, "dial_text_valign")
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { soup_checkout("dataalignv", false, true).setSubimg(real(e_.get() == "" ? "0" : e_.get())); dial_text_valign = real(e_.get() == "" ? "0" : e_.get()); }),
					new LuiImage({ value: spr_gui_alignment_v, maintain_aspect: false }).setSize(32, 32).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataalignv", e_, , true); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Line Spacing:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the gap between lines of dialogue.\nIs the line gap too big/ small for your font?\nChange this setting to your liking!\nUse [c_red]-1[/] or leave blank to reset.", true, , true),
					new LuiInput({ value: dial_text_line_spacing, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_text_line_spacing); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? -1 : value_; SYSTEMUI.dial_text_line_spacing = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Auto Wrap:", width: 100, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether to automatically wrap text to a new line\nif the text width exceeds the dialogue box.\nTurning this off means you'll have to manually\nadd newline literals(\"\\n\") or \"[newl]\" yourself.", true),
					new LuiToggleSwitch({ value: dial_auto_wrap, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_auto_wrap"),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Auto Page:", width: 100, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether to automatically add new pages when\nyour text overflows the dialogue box.\n[c_yellow]This [c_red]disables[c_yellow] vertical text alignments if it's on.[c_white]\nPage created this way will [c_yellow]not start with\nan asterisk if auto-asterisk is on.", true, , true),
					new LuiToggleSwitch({ value: dial_auto_page, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_auto_page"),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Right-To-Left:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether dialogue should be read right-to-left.", true, , true),
					new LuiToggleSwitch({ value: dial_rtl, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_rtl"),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Deltarune Choicer:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether the typewriter choicer\nshould act similarly to Deltarune's.\nThis value can be [rainbow]changed dynamically[/] if using\n[c_yellow][[choicer,1,2,3,4,startat,icon,frame,scale,angle,r,g,b,DELTARUNE-LIKE][/].", true, , true),
					new LuiToggleSwitch({ value: dial_choices_deltarunelike, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_choices_deltarunelike").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { if ( dial_choices_deltarunelike ) { sfx_play(snd_chest); } }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Symbols Delay:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Always add a delay to the typewriter\nwhen encountering symbols?\nThis may get in the way when it comes\nto characters that talk in\nunconventional ways.", true, , true),
					new LuiToggleSwitch({ value: global.pref.pausesymbols, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "pausesymbols").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { global.pref.pausesymbols = e_.get(); SYSTEMUI.save_pref(); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Auto Asterisk:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether to automatically add asterisks\nat the start of text.\nTurning this off means [c_yellow]you'll have\nto manually add asterisks yourself.\n[/]Recommended off.", true, , true),
					new LuiToggleSwitch({ value: dial_point_auto, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_point_auto").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { global.pref.autopoint = e_.get(); SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Asterisk Chr:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("The character(s) to be\nplaced at the beginning of text.\n[c_yellow]Only works for auto-asterisk.\nIf left blank, auto-asterisk will be disabled.", true, , true),
					new LuiInput({ value: dial_point_chr, height: 40, placeholder: ">, *, $, ->, @, etc.", offset: 12, type_sfx: snd_txttype, max_length: 2, color_normal: c_white, color_hover: c_gray, }).bindVariable(self, "dial_point_chr"),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Asterisk Color:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the auto-asterisk.", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_asterisk),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_point_clr }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataasterisk", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_point_clr = e_.color_blend; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_white ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_white); SYSTEMUI.dial_point_clr = c_white; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text Shadow:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether text should cast a shadow.", true, , true),
					new LuiToggleSwitch({ value: dial_text_shdw, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_text_shdw"),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Shadow Color:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the shadow.\n[c_yellow]Only works if text shadows are enabled.", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_shadow),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_text_shdw_clr }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datashadow", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_text_shdw_clr = e_.color_blend; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_deltarune ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_deltarune); SYSTEMUI.dial_text_shdw_clr = c_deltarune; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text Gradient:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether [c_yellow][wheel]all[/] text should have a gradient.", true, , true),
					new LuiToggleSwitch({ value: dial_gradient, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_gradient").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { dial_gradient_orig = e_.get(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Gradient Color:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the gradient.\n[c_yellow]Only works if text gradients are enabled.", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_gradient),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_gradient_clr }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datagradient", e_, , true); }).addEvent(LUI_EV_SHOW, function(e_) { e_.color_blend = SYSTEMUI.dial_gradient_clr; }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_gradient_clr = e_.color_blend; SYSTEMUI.dial_gradient_clr_orig = SYSTEMUI.dial_gradient_clr; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_white ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_white); SYSTEMUI.dial_gradient_clr = c_white; SYSTEMUI.dial_gradient_clr_orig = SYSTEMUI.dial_gradient_clr; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Highlight Color:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the highlight.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[fx,colorhigh,r,g,b,frames][/].", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_highlight),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_highlight }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datahighlight", e_, , true); }).addEvent(LUI_EV_SHOW, function(e_) { e_.color_blend = SYSTEMUI.dial_highlight; }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_highlight = e_.color_blend; SYSTEMUI.dial_highlight_orig = SYSTEMUI.dial_highlight; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_gold ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_gold); SYSTEMUI.dial_highlight = c_gold; SYSTEMUI.dial_highlight_orig = SYSTEMUI.dial_highlight; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Underline Color:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the underline.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[fx,colorunder,r,g,b,frames][/].", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_underline),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_underline }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataunderline", e_, , true); }).addEvent(LUI_EV_SHOW, function(e_) { e_.color_blend = SYSTEMUI.dial_underline; }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_underline = e_.color_blend; SYSTEMUI.dial_underline_orig = SYSTEMUI.dial_underline; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_gray ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_gray); SYSTEMUI.dial_underline = c_gray; SYSTEMUI.dial_underline_orig = SYSTEMUI.dial_underline; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "Strikethrough Color:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the strikethrough.\nThis value can be [rainbow]changed dynamically[/]\nif using [c_yellow][[fx,colorstrike,r,g,b,frames][/].", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_striket),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: dial_striket }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datastriket", e_, , true); }).addEvent(LUI_EV_SHOW, function(e_) { e_.color_blend = SYSTEMUI.dial_striket; }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.dial_striket = e_.color_blend; SYSTEMUI.dial_striket_orig = SYSTEMUI.dial_striket; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_white ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_white); SYSTEMUI.dial_striket = c_white; SYSTEMUI.dial_striket_orig = SYSTEMUI.dial_striket; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Text Smoothing:", width: 140, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes how much text is visible while\ntyping out. Higher numbers will allow more\ntext to be visible as it fades in.", true, , true),
					new LuiInput({ value: typist_smooth, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.typist_smooth); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.typist_smooth = index_; typist.in(SYSTEMUI.typist_spd, SYSTEMUI.typist_smooth); }),
				]),
			
				new LuiButton({ text: "Edit Font Separation", height: 40, }).addEvent(LUI_EV_CLICK, external_edit_fonts),
				new LuiButton({ text: "Typewriter Animation Builder", height: 40, }).addEvent(LUI_EV_CLICK, external_edit_typew).setTooltip("Edit how the typewriter types out characters.\nBefore editing, set [c_yellow]text smoothing[/] to\na value [c_cyan]greater than 0[/].\nSomewhere around 15 should be good.\nExperiment with the\ntext smoothing value while editing this.", true, , true),

				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Indicator Sprite:", width: 160, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator sprite used\nwhen dialogue has ended.\n[c_yellow]Leave blank or -1 for no indicator.", true, , true),
					new LuiInput({ value: dial_indicator, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) {
						var value_ = e_.get(), face_ = get_face(value_), bord_ = get_border(value_), icon_ = get_icon(value_);
						if ( face_ == -1 && bord_ == -1 && icon_ == -1 ) { SYSTEMUI.dial_indicator = -1; soup_checkout("dataindic", false, true).set(SYSTEMUI.dial_indicator); }
						else {
							if ( face_ != -1 ) { SYSTEMUI.dial_indicator = face_; soup_checkout("dataindic", false, true).set(SYSTEMUI.dial_indicator); exit; } 
							if ( bord_ != -1 ) { SYSTEMUI.dial_indicator = bord_; soup_checkout("dataindic", false, true).set(SYSTEMUI.dial_indicator); exit; } 
							if ( icon_ != -1 ) { SYSTEMUI.dial_indicator = icon_; soup_checkout("dataindic", false, true).set(SYSTEMUI.dial_indicator); exit; }
						}
					}),
					new LuiImage({ value: dial_indicator, draw_normal: true, color: dial_text_c }).setSize(40, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("dataindic", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { if ( SYSTEMUI.dial_indicator != -1 ) { e_.setSize(sprite_get_width(e_.get()), sprite_get_height(e_.get())); audio_stop_sound(snd_updated); sfx_play(snd_updated); } }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.value == -1 ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.set(-1); SYSTEMUI.dial_indicator = -1; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Image Index:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's image index.", true, , true),
					new LuiInput({ value: dial_indicator_index, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_index); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_indicator_index = index_; soup_checkout("dataindic", false, true).setSubimg(index_); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Image Speed:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's image speed.", true, , true),
					new LuiInput({ value: dial_indicator_index, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_index); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_indicator_spd = index_; soup_checkout("dataindic", false, true).imgspd = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Image Scale:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's image scale.", true, , true),
					new LuiInput({ value: dial_indicator_scale, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_scale); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 1 : value_; SYSTEMUI.dial_indicator_scale = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Image XOff:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's x offset.", true, , true),
					new LuiInput({ value: dial_indicator_xoff, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_xoff); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_indicator_xoff = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Image YOff:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's y offset.", true, , true),
					new LuiInput({ value: dial_indicator_yoff, height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_yoff); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 0 : value_; SYSTEMUI.dial_indicator_yoff = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Blink Speed:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's blinking speed.\nMeasured in milliseconds.", true, , true),
					new LuiInput({ height: 40, placeholder: "123456", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_blink); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { var value_ = real_ext(e_.get()), index_ = value_ == "" ? 300 : value_; SYSTEMUI.dial_indicator_blink = index_; soup_checkout("dataindic", false, true).blink = index_; }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image angle
						new LuiText({ value: "Image Angle:", width: 120, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the indicator's angle.", true, , true),
						new LuiSlider({ min_value: 0, color_text: c_black, color_text_drag: c_white, max_value: 360, rounding: true, display_value: true, bar_sprite: spr_border_header, bar_sprite_back: spr_border_header, }).addEvent(LUI_EV_SHOW, function(e_) { e_.set(SYSTEMUI.dial_indicator_angle); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
							var value_ = real(e_.get()); SYSTEMUI.dial_indicator_angle = value_; soup_checkout("dataindic", false, true).angle = value_;
						}),
					]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Animation bounce back
					new LuiText({ value: "Bounce Back:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Whether the indicator sprite should reverse\nits animation once its animation ends.", true, , true),
					new LuiToggleSwitch({ value: dial_indicator_anim, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(self, "dial_indicator_anim").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { soup_checkout("dataindic", false, true).bounce = e_.get(); }),
				]),
			]);
		
			soupy_lui.addContent(soupy_panel_style); //Add everything to the main ui
		#endregion
		
		#region Extra Panel
			var x1_ = 10, y1_ = 45, x2_ = 600, y2_ = 385, w_ = x2_ - x1_, h_ = y2_ - y1_;
			soupy_panel_extra = new LuiScrollPanel({ x: 10, y: 45, width: w_, height: h_, scroll_pin_edge_offset:10, sprite_panel: false, sound_right: snd_throw, }) //Start containter
			.addContent([
				new LuiText({ value: "Trying to export your dialogue?", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(3),
				new LuiText({ value: "Press either ESCAPE, F1, or END for export options!", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(3),
				new LuiHorizontalRule({ height: 5, }),
				new LuiText({ value: "Quick Export Shortcuts:", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(10),
				new LuiText({ value: "Quick Static: CTRL+Q | Quick Typewriter: CTRL+W", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(3),
				new LuiText({ value: "Quick Stack: CTRL+E | Quick Animated: CTRL+R", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(3),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "GIF BG Color:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the [c_lime]green screen[/] for GIFs.\nGIFs don't support transparency, so this is needed.", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_gifcolor),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: screenshot_back }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datagifcolor", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { e_.set(spr_pixel); SYSTEMUI.screenshot_back = e_.color_blend; audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); global.pref.gifbgclr = screenshot_back; save_pref(); }).addEvent(LUI_EV_CLICK_R, function(e_) { if ( e_.color_blend == c_lime ) { exit; } e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); e_.setColor(c_lime); SYSTEMUI.screenshot_back = c_lime; sfx_play(snd_hurtpowerful); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Show Ref:", text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Should the reference image\nbe visible on export?", true, , true),
					new LuiToggleSwitch({ value: global.pref.showref, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "showref").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
				
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Bigger Resolution:", width: 170, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Export all dialogue in UTDR's native resolution of 640x480.\nHelpful for [c_yellow][slant]arbitrary borders[/] as your sprites may get\ncut off on export if you import a border of an unusual size.", true, , true),
					new LuiToggleSwitch({ value: global.pref.sizematters, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "sizematters").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "To The Top:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("If [c_yellow]Bigger Resolution is true[/], then this will\nsend the dialogue box to the top.", true, , true),
					new LuiToggleSwitch({ value: global.pref.sizematterstop, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "sizematterstop").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiText({ value: "Quick Ref Shortcuts:", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(10),
				new LuiText({ value: "Update Ref: CTRL+1 | View Ref: CTRL+2", auto_width: false, auto_height: false, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setPadding(3),
				new LuiButton({ text: "Update Reference Image", height: 40, }).addEvent(LUI_EV_CLICK, function () { SYSTEMUI.ui_updateref(); }).setTooltip("Adds an image to be shown\nwhen exporting dialogue.\nIdeally a resolution of 640x480."),
				new LuiButton({ text: "View Reference Image", height: 40, }).addEvent(LUI_EV_CLICK, function () { SYSTEMUI.ui_viewref(); }),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Sprite image scale
					new LuiText({ value: "Update Delay:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("( - n# (45 recommended))\nChanges how long it takes for the generator\nto update your output text.\n[c_yellow]Lower values and frequent updating may cause\nlag or other unexpected issues.", true, , true),
					new LuiInput({ value: dial_updatet_max, height: 40, placeholder: "1 - n# (45 recommended)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, input_mode: LUI_INPUT_MODE.numbers, }).bindVariable(self, "dial_updatet_max").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var get_ = e_.get(), value_ = real(get_ == "" ? 45 : get_); SYSTEMUI.dial_updatet_max = value_;
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Hide Success:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Hides the export success message.", true, , true),
					new LuiToggleSwitch({ value: global.pref.hidemessages, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "hidemessages").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Confirm Export:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Preview the animated dialogue\nbefore exporting on finish?\nOnly applies to [c_cyan]animated exports[/].", true, , true),
					new LuiToggleSwitch({ value: global.pref.confirmexport, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "confirmexport").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Show Result:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Show your generated dialogue\nonce export is done?", true, , true),
					new LuiToggleSwitch({ value: global.pref.openresult, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "openresult").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Update Check:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Check for updates upon startup?", true, , true),
					new LuiToggleSwitch({ value: global.pref.checkupdates, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "checkupdates").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Mute Audio:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Disable all sound effects.", true, , true),
					new LuiToggleSwitch({ value: global.pref.killaudio, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "killaudio").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a color
					new LuiText({ value: "UI Color:", width: 130, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the color of the UI.\nDisables [c_yellow]Random Theme[/].", true, , true),
					new LuiButton({ text: "Pick...", height: 40, }).addEvent(LUI_EV_CLICK, soupy_color_picker_uicolor),
					new LuiImage({ value: spr_pixel, maintain_aspect: false, color: ui_accentcolor }).setSize(80, 40).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datamainuicolor", e_, , true); }).addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "xscale", 0, 1, global.Ease.OutElastic, 10); element_.main_ui.animate(element_, "yscale", 0, 1, global.Ease.OutElastic, 5); sfx_play(snd_squish); })
					.addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						e_.set(spr_pixel); 
						global.pref.randomclr = false; 
						SYSTEMUI.ui_accentcolor = e_.color_blend; 
						global.pref.themeclr = SYSTEMUI.ui_accentcolor;
						SYSTEMUI.soupy_lui.style.color_secondary = SYSTEMUI.ui_accentcolor;
						SYSTEMUI.soupy_lui.updateMainUiSurface();
						var i = 0, count_ = array_length(SYSTEMUI.butt);
						repeat ( count_ ) { 
							SYSTEMUI.butt[i].data.color = SYSTEMUI.ui_accentcolor; if ( SYSTEMUI.butt[i].data.color_butt != c_yellow ) { SYSTEMUI.butt[i].data.color_butt = SYSTEMUI.ui_accentcolor; }
						i++; }
						audio_stop_sound(snd_equip2); sfx_play(snd_equip2, , , 1.3); SYSTEMUI.save_pref(); 
					}).addEvent(LUI_EV_CLICK_R, function(e_) { 
						if ( e_.color_blend == c_orange ) { exit; } 
						e_.main_ui.animate(e_, "xscale", 0, 1, global.Ease.OutElastic, 10); e_.main_ui.animate(e_, "yscale", 0, 1, global.Ease.OutElastic, 5); 
						e_.setColor(c_orange); 
						SYSTEMUI.ui_accentcolor = c_orange; sfx_play(snd_hurtpowerful);
						global.pref.randomclr = false; 
						SYSTEMUI.soupy_lui.style.color_secondary = SYSTEMUI.ui_accentcolor;
						SYSTEMUI.soupy_lui.updateMainUiSurface();
						var i = 0, count_ = array_length(butt);
						repeat ( count_ ) { 
							butt[i].data.color = ui_accentcolor; if ( butt[i].data.color_butt != c_yellow ) { butt[i].data.color_butt = ui_accentcolor; }
						i++; }
						global.pref.themeclr = SYSTEMUI.ui_accentcolor; SYSTEMUI.save_pref(); 
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Random Theme:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("[wave][rainbow]Let's have a little fun!\n[/]Randomizes the UI theme on startup.\nYou can also randomize the color by\njust repeatedly toggling this switch.", true, , true),
					new LuiToggleSwitch({ value: global.pref.randomclr, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "randomclr").addEvent(LUI_EV_VALUE_UPDATE, function(e_) {
						ui_accentcolor = global.pref.randomclr ? make_color_hsv(irandom(255), irandom_range(150, 230), 255) : global.pref.themeclr;
						global.pref.themeclr = ui_accentcolor;
						soupy_lui.style.color_secondary = ui_accentcolor;
						soupy_lui.updateMainUiSurface();
						soup_checkout("datamainuicolor", false, true).setColor(ui_accentcolor);
						var i = 0, count_ = array_length(butt);
						repeat ( count_ ) { 
							butt[i].data.color = ui_accentcolor; if ( butt[i].data.color_butt != c_yellow ) { butt[i].data.color_butt = ui_accentcolor; }
						i++; }
						save_pref();
					}),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Dynamic Icon:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Should the icon change based\non your theme color?\nWindows only.", true, , true),
					new LuiToggleSwitch({ value: global.pref.soupyicon, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "soupyicon").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { window_reset_icon(); SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "3D BG:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Enable the 3D background?\nMight cause some performance\nissues on some devices.", true, , true),
					new LuiToggleSwitch({ value: global.pref.bg3d, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "bg3d").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([
					new LuiText({ value: "Show FPS:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Show the tool's frames\nper second(FPS)?", true, , true),
					new LuiToggleSwitch({ value: global.pref.showfps, ease: global.Ease.OutBack, sound_click: snd_bump, sound_click_pitch: 1.3,  }).bindVariable(global.pref, "showfps").addEvent(LUI_EV_VALUE_UPDATE, function(e_) { SYSTEMUI.save_pref(); }),
				]),
			
				new LuiRow().setFlexGrow(1).centerContent().addContent([ //Choosing a sprite
					new LuiText({ value: "Editor Font:", width: 110, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, }).setTooltip("Changes the textbox editor font.", true, , true),
					new LuiButton({ text: "Choose...", height: 40, width: 100, }).addEvent(LUI_EV_CLICK, external_choose_font),
					new LuiInput({ value: font_get_name(ui_mainfont), height: 40, placeholder: "or type. (ex: fnt_determination)", offset: 12, type_sfx: snd_txttype, color_normal: c_white, color_hover: c_gray, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datainputbox", e_, , true); }).addEvent(LUI_EV_VALUE_UPDATE, function(e_) { 
						var prev_ = soup_checkout("datafontbox", false, true), value = e_.get(); prev_.font = scribble_font_exists(value) ? value : "fnt_speech";
						if ( scribble_font_exists(value) ) { audio_stop_sound(snd_updated); sfx_play(snd_updated); }
						SYSTEMUI.ui_mainfont = asset_get_index(prev_.font);
						SYSTEMUI.textinput.SetFont(SYSTEMUI.ui_mainfont);
					}),
					new LuiText({ value: "AaBbCc", width: 100, text_halign: fa_center, text_valign: fa_middle, font: font_get_name(ui_mainfont), scribbletext: true, }).addEvent(LUI_EV_CREATE, function(e_) { soup_store("datafontbox", e_, , true); })
					.addEvent(LUI_EV_MOUSE_LEFT_PRESSED, function(element_) { element_.main_ui.animate(element_, "yoff", 0, 1, global.Ease.OutElastic, 10); sfx_play(snd_squish); })
					.addEvent(LUI_EV_CLICK_R, function(element_) {
						var input_ = soup_checkout("datainputbox", false, true), spr_ = soup_checkout("datafontbox", false, true);
						if ( spr_.font != "fnt_speech" && input_.get() != "" ) { spr_.font = "fnt_speech"; input_.set(""); sfx_play(snd_hurtpowerful); audio_stop_sound(snd_updated); }
					}),
				]),
			
				new LuiHorizontalRule({ height: 5, }),
				new LuiButton({ text: "Text Macros", height: 40, }).addEvent(LUI_EV_CLICK, soupy_ui_textmacros),
				new LuiButton({ text: "Icon Dictionary", height: 40, }).addEvent(LUI_EV_CLICK, soupy_ui_icons),
				new LuiButton({ text: "Help Guide", height: 40, }).addEvent(LUI_EV_CLICK, function() { soupy_url("https://rentry.co/utdrsoupguides", , , 0); }),
				new LuiButton({ text: "So Soupy!!", height: 40, }).addEvent(LUI_EV_CLICK, function() { soupy_url("https://www.youtube.com/watch?v=zbClYRnQQJ0", , , 0); }),
				new LuiButton({ text: "Credits", height: 40, }).addEvent(LUI_EV_CLICK, soupy_ui_credits),
			]);
		
			soupy_lui.addContent(soupy_panel_extra); //Add everything to the main ui
		#endregion

		#region Functions
			///@desc Show/ hide Lui on appropiate screens.
			ui_reset = function(updatelime_ = true) {
				if ( soupy_panel_portrait.visible ) { soupy_panel_portrait.hide(false); }
				if ( soupy_panel_border.visible ) { soupy_panel_border.hide(false); }
				if ( soupy_panel_style.visible ) { soupy_panel_style.hide(false); }
				if ( soupy_panel_extra.visible ) { soupy_panel_extra.hide(false); }
				
				var fx = true;
				switch ( ui_tab ) {
					case 0: { fx = false; } break;
					case 1: { soupy_panel_style.show(true); } break;
					case 2: { soupy_panel_portrait.show(true); } break;
					case 3: { soupy_panel_border.show(true); } break;
					case 4: { soupy_panel_extra.show(true); } break;
				}
				if ( fx && bord_visible ) { sfx_play(snd_enc1, 0, , 0.7); bord_visible = false; if ( is_android() && keyboard_virtual_status() ) { keyboard_virtual_hide(); } }
				else if ( !fx && !bord_visible ) { sfx_play(snd_enc1, 0, , 1.3); bord_visible = true; }
				if ( updatelime_ ) { soupy_lui.update(); }
			}
			ui_reset();
				
			///@desc Toggle between different exporting types and export the dialogue
			ui_export = function(type_ = 0, fmax_ = 180, delay_ = 60, quant_ = 1, xoff_ = 0, yoff_ = 0) {
				if ( !ui_preview && !ui_finished ) { soup_store("tablast", ui_tab, , true); ui_tab = -1; ui_reset(false); ui_visible = false; soup_store("lastpage", dial_text_page, , true); }
				if ( !bord_visible ) { sfx_play(snd_enc1, 0, , 1.3); bord_visible = true; } sfx_play(snd_equip);
				soupy_alarm_set("failsafe", "timer", 15);
					
				switch ( type_ ) {
					case 0: { screenshot = true; screenshot_stacked = false; } break; //Take single screenshot, no typewriter
					case 1: { //Record till dialogue ends, typewriter
						with ( record ) { enabled = true; framesmax = 0; frames = 0; type = 1; delay = delay_; quant = quant_; }
						dial_text_gif = true;
					} break;
					case 2: { //Record for a set timer, no typewriter just animated text
						with ( record ) { enabled = true; framesmax = fmax_; frames = 0; type = 0; quant = quant_; }
					} break;
					case 3: { //Take a stack of screenshots, no typewriter
						var offstruct = {
							soupstack_yoff: yoff_, //Gap between dialogue box sprites
							soupstack_xoff: xoff_, //Shift the dialogue boxes to the right by this amount
						}
						screenshot = true; screenshot_stacked = true; instance_create_depth(0, 0, 0, obj_stacker, offstruct); 
					} break;
				}
			}
		
			ui_updateref = function() {
				if ( sprite_exists(global.refimg) ) { sprite_delete(global.refimg); global.refimg = -1; }
				if ( !is_android() ) {
					var fname = $"reference{PATHSEP}reference_image.png", fnamedebug = string_replace(fname, $"reference{PATHSEP}", ""), enabler = false;
					 if ( file_exists(fname) ) { global.refimg = sprite_add_ext(fname, 1, 0, 0, true); show_debug_message($"Added \"{fnamedebug}\" from {fname}!"); enabler = true; }
					else {
						var result = get_open_filename_ext("Image File (.png, .jpg, .gif)|*.png;*.jpg;*.jpeg;*.gif", "", directory_get_pictures_path(), "Select a sprite to import.");
						if ( result == -1 || result == "" ) { sfx_play(snd_error); exit; }
						else { global.refimg = sprite_add_ext(result, 1, 0, 0, true); show_debug_message($"Added \"{filename_name(result)}\" from {result}!"); enabler = true; }
					}
					sfx_play(snd_updated); ui_refclr = c_white; TweenFire("?", SYSTEMUI, "$30", "+60", TPCol("ui_refclr>"), $15101c);
					if ( enabler ) { if ( !global.pref.sizematters ) { global.pref.sizematters = true; sfx_play(snd_bump, , , 1.3); }; }
				}
				else { soup_store("asynctype", "reference", , true); TweenScript(id, 0, 30, function () { MobileUtils_Gallery_Open_PNG(); }); }
			}
		
			ui_mini = function () {
				if ( instance_exists(obj_mini) ) { with ( obj_mini ) {  
					if ( SYSTEMUI.dial_text_page == page ) { alpha = 1; active = false; }
				} }
			}
		
			ui_viewref = function() { TweenDestroy(SYSTEMUI); TweenFire("?", SYSTEMUI, "$15", TPCol("ui_refclr>"), c_white); SYSTEMUI.ui_visible = false; SYSTEMUI.soupy_lui.hide(); SYSTEMUI.ui_viewing = true; soup_store("bordvis", SYSTEMUI.bord_visible, , true); SYSTEMUI.bord_visible = true; }
			ui_unviewref = function() { TweenDestroy(SYSTEMUI); TweenFire("?", SYSTEMUI, "$15", TPCol("ui_refclr>"), $15101c); SYSTEMUI.ui_visible = true; SYSTEMUI.ui_viewing = false; SYSTEMUI.bord_visible = soup_checkout("bordvis", , true); mouse_clear(mb_left); SYSTEMUI.soupy_lui.show(); sfx_play(snd_enc1); }
		#endregion
	#endregion
}