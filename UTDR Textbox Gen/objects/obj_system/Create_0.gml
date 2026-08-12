///@desc Init
//if ( live_call() ) { return live_result; } 
android_path = ""; //Safe path to save stuff in
if ( !is_android() ) { instance_create_depth(0, 0, -2, obj_windows_icon); }
if ( file_exists("soupysprite.png") ) { file_delete("soupysprite.png"); }
#region Loading Preferences
	ui_loadprefs = function () { 
			if ( file_exists(PREF_SOUP) ) {
			var buff_ = buffer_load(PREF_SOUP), data_ = buffer_read(buff_, buffer_text), pref_ = undefined;
			buffer_delete(buff_);
			try { pref_ = json_parse(data_); } catch(err_) { show_debug_message(err_.message); }
	
			if ( is_struct(pref_) ) {
				var get_ = pref_[$ "firsttime"]; global.pref.firsttime = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "killaudio"]; global.pref.killaudio = !is_undefined(get_) ? get_ : false;
				var get_ = pref_[$ "randomclr"]; global.pref.randomclr = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "sizematters"]; global.pref.sizematters = !is_undefined(get_) ? get_ : false;
				var get_ = pref_[$ "sizematterstop"]; global.pref.sizematterstop = !is_undefined(get_) ? get_ : false;
				var get_ = pref_[$ "hidemessages"]; global.pref.hidemessages = !is_undefined(get_) ? get_ : false;
				var get_ = pref_[$ "checkupdates"]; global.pref.checkupdates = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "showref"]; global.pref.showref = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "openresult"]; global.pref.openresult = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "bg3d"]; global.pref.bg3d = !is_undefined(get_) ? get_ : ( is_android() ? false : true );
				var get_ = pref_[$ "showfps"]; global.pref.showfps = !is_undefined(get_) ? get_ : false;
				var get_ = pref_[$ "fix"]; global.pref.fix = !is_undefined(get_) ? get_ : false;
				var get_ = pref_[$ "confirmexport"]; global.pref.confirmexport = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "pausesymbols"]; global.pref.pausesymbols = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "soupyicon"]; global.pref.soupyicon = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "autoscale"]; global.pref.autoscale = !is_undefined(get_) ? get_ : true;
				var get_ = pref_[$ "presets"]; global.pref.presets = !is_undefined(get_) ? get_ : {};
				var get_ = pref_[$ "gifbgclr"]; global.pref.gifbgclr = !is_undefined(get_) ? get_ : c_lime; if ( global.pref.gifbgclr == c_fuchsia && !global.pref.fix ) { global.pref.gifbgclr = c_lime; global.pref.fix = true; } screenshot_back = global.pref.gifbgclr;
				var get_ = pref_[$ "autopoint"]; global.pref.autopoint = !is_undefined(get_) ? get_ : true; dial_point_auto = global.pref.autopoint;
				var get_ = pref_[$ "macros"]; global.pref.macros = !is_undefined(get_) ? get_ : { example: "[c_go][wave][pulse]I'm so soupy!![/]", example2: "This is a really long macrooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo", }; 
				var get_ = pref_[$ "themeclr"]; global.pref.themeclr = !is_undefined(get_) ? get_ : c_orange; if ( !global.pref.randomclr && is_android() ) { 
					ui_accentcolor = global.pref.themeclr;
					soup_checkout("datamainuicolor", false, true).setColor(ui_accentcolor);
					soup_checkout("datagifcolor", false, true).setColor(screenshot_back);
					var i = 0, count_ = array_length(butt);
					repeat ( count_ ) { 
						butt[i].data.color = ui_accentcolor; if ( butt[i].data.color_butt != c_yellow ) { butt[i].data.color_butt = ui_accentcolor; }
					i++; }
					soupy_lui.style.color_secondary = ui_accentcolor;
					soupy_lui.updateMainUiSurface();
				}
			}
		}
	}
	if ( !is_android() ) { ui_loadprefs(); }
	
	#region Http.gml
		http_active = false;
		http_requests = ds_map_create();
	#endregion
#endregion

#region Dialogue Box
	outlinesoup_init(, , , , 2); soupyclipm_init(); display_set_gui_size(640, 480);
	spr_bord = spr_border_undertale; //Border Sprite
	bord_name = "spr_border_undertale"; //Border internal name
	bord_clr = c_white; //Border Color
	bord_out = true; //Whether border should have an outline
	bord_prev = spr_bord; //Previous border
	bord_visible = true; //Whether the dialogue box and text is visible
	bord_box_visible = true; //Whether the dialogue box is visible
	bord_index = 0; //Border image index
	bord_spd = 0; //Border image speed
	bord_anim = true; //Animation type ( 0 - Start over, 1 - Bounce back )
	bord_anim_track = 0;
	bord_scale = 2; //Border sprite scale
	bord_stretch = false; //Whether the nineslice border should stretch or tile
	bord_xoff = 0; //Arb Border X off
	bord_yoff = 0; //Arb Border Y off
	bord_angle = 0; //Arb Border Angle
#endregion

#region Dialogue Text
	#region Adjust Fonts
		var i = 0, arr = tag_get_assets("fonts"), len = array_length(arr);
		repeat (  len ) {
			var cur_ = arr[i];
			scribble_font_bake_outline_and_shadow(cur_, $"{cur_}_s", 0, 0, SCRIBBLE_OUTLINE.NO_OUTLINE, 0, false);
			scribble_font_bake_outline_and_shadow(cur_, $"{cur_}_outline", 0, 0, SCRIBBLE_OUTLINE.EIGHT_DIR, 0, false);
			var h_ = scribble_glyph_get($"{cur_}_s", "W", SCRIBBLE_GLYPH.FONT_HEIGHT), x_ = scribble_glyph_get($"{cur_}_s", "A", SCRIBBLE_GLYPH.LEFT_OFFSET);
			scribble_glyph_set($"{cur_}_outline", all, SCRIBBLE_GLYPH.FONT_HEIGHT, h_); scribble_glyph_set($"{cur_}_outline", all, SCRIBBLE_GLYPH.LEFT_OFFSET, x_);
			scribble_font_delete(cur_); scribble_font_rename($"{cur_}_s", cur_);
		i++; }
	
		scribble_glyph_set("fnt_sans", all, SCRIBBLE_GLYPH.Y_OFFSET, 1); scribble_glyph_set("fnt_sans", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_sans_outline", all, SCRIBBLE_GLYPH.Y_OFFSET, 0); scribble_glyph_set("fnt_sans_outline", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_sans_alt", all, SCRIBBLE_GLYPH.Y_OFFSET, 1); scribble_glyph_set("fnt_sans_alt", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_sans_alt_outline", all, SCRIBBLE_GLYPH.Y_OFFSET, 0); scribble_glyph_set("fnt_sans_alt_outline", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_papyrus", all, SCRIBBLE_GLYPH.Y_OFFSET, -1); scribble_glyph_set("fnt_papyrus", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_papyrus_outline", all, SCRIBBLE_GLYPH.Y_OFFSET, -2); scribble_glyph_set("fnt_papyrus_outline", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_papyrus_alt", all, SCRIBBLE_GLYPH.Y_OFFSET, -1); scribble_glyph_set("fnt_papyrus_alt", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_papyrus_alt_outline", all, SCRIBBLE_GLYPH.Y_OFFSET, -2); scribble_glyph_set("fnt_papyrus_alt_outline", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14);
		scribble_glyph_set("fnt_determination", all, SCRIBBLE_GLYPH.X_OFFSET, 0); scribble_glyph_set("fnt_determination", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14); scribble_glyph_set("fnt_determination", all, SCRIBBLE_GLYPH.Y_OFFSET, -2);  
		scribble_glyph_set("fnt_determination_outline", all, SCRIBBLE_GLYPH.X_OFFSET, -1); scribble_glyph_set("fnt_determination_outline", all, SCRIBBLE_GLYPH.FONT_HEIGHT, 14); scribble_glyph_set("fnt_determination_outline", all, SCRIBBLE_GLYPH.Y_OFFSET, -3);  
		//I'm so happy Deltarune doesn't introduce new fonts cause fuck this honestly. Never want to do this again.
	#endregion
	
	dial_text = ""; //Dialogue Text
	dial_font = "fnt_determination"; //Dialogue Font
	dial_text_scale = 2; //Text Scale
	dial_text_c = c_white; //Text Color
	dial_text_gif = false; //Whether to enable typewriting
	dial_updatet = 0; //Dialogue update timer
	dial_updatet_max = 45; //Dialogue update timer delay
	dial_text_outline = c_black; //Dialogue Outline Color
	dial_point_auto = global.pref.autopoint; //Whether to automatically add points
	dial_point_chr = "*"; //Dialogue Point Character
	dial_point_clr = c_white; dial_point_clr_anim = c_white; dial_point_clr_anim_alpha = 0; //Dialogue Point Clr and flash color
	dial_auto_wrap = true; //Whether to automatically wrap dialogue to new lines
	dial_wrap_count = 1; //Current wrapped line
	dial_text_page = 0; //Current page
	dial_text_page_c = 0; //Amount of pages in a dialogue sequence
	dial_text_line_spacing = -1; //Spacing between lines. -1 for auto.
	point_visible = false; //Whether the auto-points are visible
	dial_text_xoff = 0; //Offset X Text
	dial_text_yoff = 0; //Offset Y Text
	dial_text_halign = 0; //Text H alignment
	dial_text_valign = 0; //Text V alignment
	dial_rtl = false; //Right-to-left text
	dial_rand = false; //Randomized animation
	dial_gradient = false; //Text gradient
	dial_gradient_orig = dial_gradient; //Text gradient original
	dial_gradient_clr = c_white; //Text gradient color
	dial_gradient_clr_orig = dial_gradient_clr; //Text original gradient color
	dial_indicator = -1; //Dialogue ended indicator
	dial_indicator_index = 0;
	dial_indicator_spd = 0; 
	dial_indicator_anim = 0; dial_indicator_anim_track = 0;
	dial_indicator_visible = false; dial_indicator_scale = 1; dial_indicator_xoff = 0; dial_indicator_yoff = 0; dial_indicator_angle = 0; dial_indicator_blink = 300;
	
	dial_miniface = []; dial_miniface_index = []; dial_miniface_set = []; //Mini face and image index per line and whether to animate
	dial_highlight = c_gold; dial_highlight_orig = dial_highlight; //Highlight text
	dial_underline = c_gray; dial_underline_orig = dial_underline; //Underline text
	dial_striket = c_white; dial_striket_orig = dial_striket; //Strikethrough text
	dial_nametag = ""; //Character speaking
	
	dial_glow = false; dial_glow_orig = false; //Whether text can glow
	dial_glow_clr = c_white; dial_glow_clr_orig = c_white; //Glow clr
	dial_glow_time = 1000; dial_glow_time_orig = 1000; //Glow pulse timer
	
	#region Typist
		typist = scribble_typist(); //Dialogue Engine
		typist_spd = 0.5; //Typewriter speed
		typist_spd_orig = typist_spd; //Typewriter original speed
		typist_smooth = 0; //Typewriter smooth
		typist.in(typist_spd, typist_smooth);
		typist.function_per_char(function(_element, _position, _typist) { //Function to run per character
			if ( dial_text_page > dial_text_page_c - 1 && dial_text_page_c > 1 ) { exit; } //Prevents the stack export from going out of bounds
			
			#region Auto Asterisks
				var mychr = chr(_element.get_glyph_data(_position - 1).unicode); //Get the currently revealed character
				var mychr2 = chr(_element.get_glyph_data(_position).unicode); //Get the next character
				if ( mychr == chr(10) && mychr2 != " " && mychr2 != "" ) { //Newline
					var lined = _element.get_line_data(dial_wrap_count, dial_text_page);
					if ( !lined.forced_break ) { dial_wrap_count++; } //Account for cases where there's a line wrap and a break
					dial_wrap_count++;
				}
				if ( !point_visible && mychr2 != "" && mychr2 != " " ) { point_visible = true; }
			#endregion
		
			#region Animate Face
				if ( ( FACE_USING && dial_face_auto ) && string_lettersdigits(mychr) != "" ) { //Animate the face while dialogue is typing out. Only animate if there's letters and numbers being said
					static anim_timer = 0; anim_timer++;
					if ( anim_timer > dial_face_anim ) { anim_timer = 0; FACE_INDEX++; }
				}
				
				if ( AUTO_ASTERISK && ( dial_miniface[dial_wrap_count - 1] > 0 && dial_miniface_set[dial_wrap_count - 1] == -1 && dial_face_auto ) && string_lettersdigits(mychr) != "" ) { //Animate the mini face while dialogue is typing out. Only animate if there's letters and numbers being said
					static anim_timer = 0; anim_timer++;
					if ( anim_timer > dial_face_anim ) { anim_timer = 0; dial_miniface_index[dial_wrap_count - 1]++; }
				}
			#endregion
			
			#region Delay on symbols
				if ( !global.pref.pausesymbols ) { exit; }
				var str = ",<.>/?;:[{]}\\|`~!@#$%^&*()_-+=";
				var i = 0, len = string_length(str);
				repeat ( len ) {
					var cur = string_char_at(str, i);
					if ( mychr == cur ) { typist.pause(); TweenScript(self, 0, 30, function () { SYSTEMUI.typist.unpause(); }); }
				i++; }
			#endregion
		});
		typist.function_on_complete(function() { //Function to run once the dialogue is complete
			if ( dial_text_page > dial_text_page_c - 1 && dial_text_page_c > 1 ) { exit; } //Prevents the stack export from going out of bounds
			dial_indicator_visible = true;
			if ( dial_face_auto ) { FACE_INDEX = 0; }
			if ( !dial_face_keep ) { FACE_CURRENT = FACE_ORIGINAL; } //Switch back to the original face
			typist_spd = typist_spd_orig; //Switch back to the original typewriter speed
			
			if ( !instance_exists(obj_mini) ) { exit; }
			with ( obj_mini ) { if ( page == other.dial_text_page && !sticker ) { active = true; TweenFire("$13", $"~{smooth ? "ocirc" : "linear"}", "xoff", 30, 0, "alpha", 0, 1); } } 
		});
		
		typist_reset = function () { dial_glow_time = dial_glow_time_orig; dial_glow = dial_glow_orig; dial_glow_clr = dial_glow_clr_orig; soup_store("offset", , , true); dial_text_shdw_clr = dial_text_shdw_clr_orig; dial_text_shdw_clr_g = dial_text_shdw_clr_g_orig; dial_choices = ["", "", "", ""]; dial_choices_scaleoff = 0; dial_striket = dial_striket_orig; dial_underline = dial_underline_orig; dial_highlight = dial_highlight_orig; dial_wrap_count = 1; dial_miniface = [-1]; dial_miniface_index = [0]; dial_miniface_set = [-1]; dial_indicator_visible = false; dial_gradient = dial_gradient_orig; dial_gradient_clr = dial_gradient_clr_orig; dial_face_angle = dial_face_angle_orig; dial_face_alpha = dial_face_alpha_orig; dial_face_xoff = 0; dial_face_yoff = 0; dial_face_xscale_off = 0; dial_face_yscale_off = 0; } //Function to reset portrait modifications after dialogue finishes
		
		#region Ease Builder
			typist_ease = { type: SCRIBBLE_EASE.LINEAR, x: 0, y: 0, xscale: 1, yscale: 1, angle: 0, alpha: 0, };
			typist.ease(typist_ease.type, typist_ease.x, typist_ease.y, typist_ease.xscale, typist_ease.yscale, typist_ease.angle, typist_ease.alpha);
		#endregion
	#endregion
	
	#region Typist Events
		#region Dialogue Settings
			scribble_typists_add_event("face", function(_, param) { //Switch to a new portrait sprite
				FACE_PREVIOUS = FACE_CURRENT; //Get the previous face
				FACE_CURRENT = get_face(param[0], array_length(param) > 1 ? param[1] : -1);
				if ( FACE_USING ) { FACE_INTERNAL = param[0]; }
				FACE_INDEX = array_length(param) > 2 && real_ext(param[2]) != "" ? real_ext(param[2]) : ( array_length(param) > 3 && real_ext(param[3]) != "" && bool(real_ext(param[3])) ? sprite_get_number(FACE_CURRENT) - 1 : 0 );
			});
			scribble_typists_add_event("face_orig", function(_, param) { //Change the original previous face to a new 
				FACE_ORIGINAL = get_face(param[0], array_length(param) > 1 ? param[1] : -1);
				FACE_INDEX = array_length(param) > 2 && real_ext(param[2]) != "" ? real_ext(param[2]) : ( array_length(param) > 3 && real_ext(param[3]) != "" && bool(real_ext(param[3])) ? sprite_get_number(FACE_CURRENT) - 1 : 0 );
			});
			scribble_typists_add_event("face_prev", function(_, param) { FACE_CURRENT = FACE_PREVIOUS; }); //Change the face back to the previous face
			scribble_typists_add_event("face_auto", function(_, param) { dial_face_auto = bool(string_letters(param[0])); }); //Switch the automatic animation of the face
			scribble_typists_add_event("gradient", function(_, param) { dial_gradient = bool(string_letters(param[0])); }); //Switch the gradient
			scribble_typists_add_event("face_index", function(_, param) { FACE_INDEX = real(string_digits(param[0])); }); //Change the index of the face(if dial_face_auto is off), for sprites with more sprites and expressions
			scribble_typists_add_event("face_anim", function(_, param) { dial_face_anim = real(string_digits(param[0])); }); //Changes how often the face should animate for every letter revealed
			var func_ = function(_, param) { var value_ = real_ext(param[0]); FACE_SPEED = value_ == "" ? 0 : value_; }
			scribble_typists_add_event("face_speed", func_); scribble_typists_add_event("face_spd", func_); //Change the speed of the face(if dial_face_auto is off), for sprites with more sprites and expressions
			scribble_typists_add_event("border", function(_, param) { //Switch to a new border sprite
				var bord_ = get_border(param[0]);
				spr_bord = bord_ != -1 ? bord_ : spr_border_undertale;
			});
			scribble_typists_add_event("mini", function(_, param) { //Dedicate the current line to a mini portrait [mini,character,expression,frame]
				if ( array_length(param) == 0 ) { exit; }
				var face_ = get_face(param[0], array_length(param) > 1 ? param[1] : -1), index_ = array_length(param) > 2 ? param[2] : -1;
				if ( face_ != -1 ) { SYSTEMUI.dial_miniface[SYSTEMUI.dial_wrap_count - 1] = face_; SYSTEMUI.dial_miniface_set[SYSTEMUI.dial_wrap_count - 1] = index_; SYSTEMUI.dial_miniface_index[SYSTEMUI.dial_wrap_count - 1] = index_ == -1 ? 0 : index_; exit; }
				
				var icon_ = get_icon(param[0]);
				if ( icon_ != -1 ) { SYSTEMUI.dial_miniface[SYSTEMUI.dial_wrap_count - 1] = icon_; SYSTEMUI.dial_miniface_set[SYSTEMUI.dial_wrap_count - 1] = index_; SYSTEMUI.dial_miniface_index[SYSTEMUI.dial_wrap_count - 1] = index_ == -1 ? 0 : index_; }
			});
			scribble_typists_add_event("indicator", function(_, param) { //Switch to a new indicator sprite
				var value_ = param[0], face_ = get_face(value_), bord_ = get_border(value_), icon_ = get_icon(value_);
				
				var index_ = ( array_length(param) > 1 && real_ext(param[1]) != "" ? real_ext(param[1]) : 0 );
				var spd_ = ( array_length(param) > 2 && real_ext(param[2]) != "" ? real_ext(param[2]) : 0 );
				var anim_ = ( array_length(param) > 3 && real_ext(param[3]) != "" ? real_ext(param[3]) : 0 );
				if ( face_ == -1 && bord_ == -1 && icon_ == -1 ) { SYSTEMUI.dial_indicator = -1; SYSTEMUI.dial_indicator_index = 0; SYSTEMUI.dial_indicator_spd = 0; SYSTEMUI.dial_indicator_anim = 0; }
				else {
					if ( face_ != -1 ) { SYSTEMUI.dial_indicator = face_; SYSTEMUI.dial_indicator_index = index_; SYSTEMUI.dial_indicator_spd = spd_; SYSTEMUI.dial_indicator_anim = anim_; exit; } 
					if ( bord_ != -1 ) { SYSTEMUI.dial_indicator = bord_; SYSTEMUI.dial_indicator_index = index_; SYSTEMUI.dial_indicator_spd = spd_; SYSTEMUI.dial_indicator_anim = anim_; exit; } 
					if ( icon_ != -1 ) { SYSTEMUI.dial_indicator = icon_; SYSTEMUI.dial_indicator_index = index_; SYSTEMUI.dial_indicator_spd = spd_; SYSTEMUI.dial_indicator_anim = anim_; exit; } 
				}
			});
			
			var func_ = function(_, param) { //Change the positioning of the dialogue portrait
				var xoff = ( array_length(param) > 0 && real_ext(param[0]) != "" ? real_ext(param[0]) : 0 );
				var yoff = ( array_length(param) > 1 && real_ext(param[1]) != "" ? real_ext(param[1]) : 0 );
				soup_checkout("offset", , true); soupy_alarm_set("offset", "timer", 2);
				dial_face_xoff_static = xoff; dial_face_yoff_static = yoff;
			}
			scribble_typists_add_event("offset_portrait", func_); scribble_typists_add_event("offset_p", func_); scribble_typists_add_event("offset_face", func_);
			
			var func_ = function(_, param) { //Change the positioning of the text shadow
				var xoff = ( array_length(param) > 0 && real_ext(param[0]) != "" ? real_ext(param[0]) : 0 );
				var yoff = ( array_length(param) > 1 && real_ext(param[1]) != "" ? real_ext(param[1]) : 0 );
				dial_text_shdw_x = xoff; dial_text_shdw_y = yoff;
			}
			scribble_typists_add_event("offset_shadow", func_); scribble_typists_add_event("offset_s", func_); scribble_typists_add_event("offset_shdw", func_);
			
			var func_ = function(_, param) { var value_ = real_ext(param[0]); bord_spd = value_ == "" ? 0 : value_; } 
			scribble_typists_add_event("border_speed", func_); scribble_typists_add_event("border_spd", func_); //Change the animation speed of borders
			scribble_typists_add_event("finish", function(_, param) { typist.skip(); }); //Finish all the text immediately
			scribble_typists_add_event("skip", function(_, param) { //Skips to the next page, disregarding current dialogue 
				if ( dial_text_page < dial_text_page_c - 1 ) {
					if ( array_length(param) == 0 ) { dial_text_page++; } //No argument provided? Just go to the next page
					else { dial_text_page = real(string_digits(param[0])); dial_text_page = clamp(dial_text_page, 0, dial_text_page_c); } //Go to a specific page
				}
			});
			scribble_typists_add_event("face_stick", function(_, param) { FACE_ORIGINAL = get_face(FACE_INTERNAL); }); //Make the previous dialogue face stick
			scribble_typists_add_event("face_stick_all", function(_, param) { //Make the previous dialogue face stick for all upcoming dialogue
				var i = dial_text_page, face_spr = FACE_CURRENT; 
				repeat ( ( dial_text_page_c ) - i ) { dial_face[i] = face_spr; dial_face_prev[i] = face_spr; dial_face_original[i] = face_spr; dial_face_name[i] = FACE_INTERNAL; i++; }
			});
			scribble_typists_add_event("speed_pop", function(_, param) { typist_spd = typist_spd_orig; }); //Changes the typist speed back to the default
			scribble_typists_add_event("nametag", function(_, param) { dial_nametag = ( array_length(param) > 0 ? param[0] : "" ); }); //Change name tag
			scribble_typists_add_event("choicer", function(_, param) { //Open a choice menu [choicer,option1,option2,option3,option4,startat,sprite,index,scale,angle,r,g,b,deltarunelike]
				FACE_CURRENT = -1; FACE_ORIGINAL = -1;
				TweenFire("$30", "~oback", "dial_choices_scaleoff", 0, 1);
				var choice1 = ( array_length(param) > 0 ? param[0] : "" ), choice2 = ( array_length(param) > 1 ? param[1] : "" )
				, choice3 = ( array_length(param) > 2 ? param[2] : "" ), choice4 = ( array_length(param) > 3 ? param[3] : "" );
				dial_choices = [choice1, choice2, choice3, choice4]; //Available dialogue choices
				
				var value_ = real_ext(( array_length(param) > 4 ? param[4] : "0" )); dial_choices_menu = value_ == "" ? 0 : value_;
				
				var value_ = ( array_length(param) > 5 ? param[5] : "spr_soul" ), face_ = get_face(value_), bord_ = get_border(value_), icon_ = get_icon(value_);
				if ( face_ == -1 && bord_ == -1 && icon_ == -1 ) { dial_choices_ico = spr_soul; }
				else {
					if ( face_ != -1 ) { dial_choices_ico = face_; } else if ( bord_ != -1 ) { dial_choices_ico = bord_; } else if ( icon_ != -1 ) { dial_choices_ico = icon_; }
				}
				
				var value_ = real_ext(( array_length(param) > 6 ? param[6] : "0" )); dial_choices_ico_index = value_ == "" ? 0 : value_;
				var value_ = real_ext(( array_length(param) > 7 ? param[7] : "1" )); dial_choices_ico_xs = value_ == "" ? 1 : value_; dial_choices_ico_ys = dial_choices_ico_xs;
				var value_ = real_ext(( array_length(param) > 8 ? param[8] : "0" )); dial_choices_ico_angle = value_ == "" ? 0 : value_;
				
				var getclr = real_ext(array_length(param) > 9 ? param[9] : "255"), getclr2 = real_ext(array_length(param) > 10 ? param[10] : "0"), getclr3 = real_ext(array_length(param) > 11 ? param[11] : "0");
				dial_choices_ico_clr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
				
				var value_ = real_ext(( array_length(param) > 12 ? param[12] : dial_choices_deltarunelike )); dial_choices_deltarunelike = value_ == "" ? 0 : value_;
			});
			var func_ = function(_, param) { var value_ = real_ext(( array_length(param) > 0 ? param[0] : "0" )); dial_choices_menu = value_ == "" ? 0 : value_; }
			scribble_typists_add_event("choicer_select", func_); scribble_typists_add_event("choicer_option", func_); scribble_typists_add_event("choicer_on", func_); //Select a choice
		#endregion
		
		#region Face & Border Effects
			var efxfunc = function(_, param) { //Play an effect
				var len = array_length(param);
				var delayfunc = function () { SYSTEMUI.typist.pause(); TweenScript(SYSTEMUI, 0, 1.001, function () { SYSTEMUI.typist.unpause(); }); }
				switch ( string_lower(string_trim(param[0])) ) {
					case "squash": case "squish": { TweenFire("$15", "~oquad", "dial_face_xscale_off", 0.3, 0, "dial_face_yscale_off", -0.3, 0); delayfunc(); } break; //Squish the face 
					case "squeeze": case "stretch": { TweenFire("$15", "~oquad", "dial_face_xscale_off", -0.3, 0, "dial_face_yscale_off", 0.3, 0); delayfunc(); } break; //Squeeze the face
					case "flash": { //Make the face flash a color [effect,flash,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255); dial_point_clr_anim = myclr;
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", "~oquad", "dial_point_clr_anim_alpha", 1, 0); delayfunc();
					} break;
					case "color": case "blend": { //Make the face blend to a different [effect,color,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_face_clr"), dial_face_clr, myclr); delayfunc();
					} break;
					case "colorasterisk": case "blendasterisk": case "coloraster": case "blendaster": { //Make the asterisks blend to a different [effect,color,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_point_clr"), dial_point_clr, myclr); delayfunc();
					} break;
					case "colorborder": case "blendborder": { //Make the border blend to a different [effect,colorblend,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("bord_clr"), bord_clr, myclr); delayfunc();
					} break;
					case "colorhigh": case "blendhigh": { //Make the highlight blend to a different [effect,colorhigh,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_highlight"), dial_highlight, myclr); delayfunc();
					} break;
					case "colorunder": case "blendunder": { //Make the underline blend to a different [effect,colorunder,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_underline"), dial_underline, myclr); delayfunc();
					} break;
					case "colorstrike": case "blendstrike": { //Make the strikethrough blend to a different [effect,colorstrike,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_striket"), dial_striket, myclr); delayfunc();
					} break;
					case "colorshadow": case "blendshadow": { //Make the shadow blend to a different [effect,colorshadow,r,g,b,frames,r2,g2,b2,frames2]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						
						var getclr2 = real_ext(len > 5 ? param[5] : "255"), getclr22 = real_ext(len > 6 ? param[6] : "255"), getclr32 = real_ext(len > 7 ? param[7] : "255"), time_2 = real_ext(len > 8 ? param[8] : "15");
						var myclr2 = make_color_rgb(getclr2!= "" ? getclr2 : 255, getclr22 != "" ? getclr22 : 255, getclr32 != "" ? getclr32 : 255);
						dial_text_shdw = true;
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_text_shdw_clr"), dial_text_shdw_clr, myclr); TweenFire("?", obj_system, $"${time_2 != "" ? time_2 : 15}", TPCol("dial_text_shdw_clr_g"), dial_text_shdw_clr_g, myclr2); delayfunc();
					} break;
					case "colorgrad": case "blendgrad": case "colorgradient": case "blendgradient": { //Make the gradient blend to a different [effect,colorgrad,r,g,b,frames]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						if ( !dial_gradient ) { dial_gradient = true; }
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_gradient_clr"), dial_gradient_clr, myclr); delayfunc();
					} break;
					case "colorglow": case "blendglow": { //Make the glow blend to a different [effect,colorglow,r,g,b,frames,time]
						var getclr = real_ext(len > 1 ? param[1] : "255"), getclr2 = real_ext(len > 2 ? param[2] : "255"), getclr3 = real_ext(len > 3 ? param[3] : "255"), time_ = real_ext(len > 4 ? param[4] : "15"), time_2 = real_ext(len > 5 ? param[5] : "1000");
						var myclr = make_color_rgb(getclr != "" ? getclr : 255, getclr2 != "" ? getclr2 : 255, getclr3 != "" ? getclr3 : 255);
						if ( !dial_glow ) { dial_glow = true; } dial_glow_time = time_2 != "" ? time_2 : 1000;
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 15}", TPCol("dial_glow_clr"), dial_glow_clr, myclr); delayfunc();
					} break;
					case "fade": case "ghost": case "opacity": { //Make the face fade out to the specified target number [effect,fade,#,frames]
						var getamt = real_ext(len > 1 ? param[1] : "0"), time_ = real_ext(len > 2 ? param[2] : "30");
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 30}", "dial_face_alpha>", getamt != "" ? getamt : 0); delayfunc();
					} break;
					case "index": case "frame": case "img": { //Make the face's sprite index go to the specified target number [fx,index,#,frames]
						var getamt = real_ext(len > 1 ? param[1] : sprite_get_number(FACE_CURRENT) - 1), time_ = real_ext(len > 2 ? param[2] : "30");
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 30}", TPArray(SYSTEMUI.dial_face_index, SYSTEMUI.dial_text_page), FACE_INDEX, getamt == "" ? sprite_get_number(FACE_CURRENT) - 1 : getamt); delayfunc();
					} break;
					case "indexbord": case "framebord": case "imgbord": case "indexborder": case "frameborder": case "imgborder": { //Make the border's sprite index go to the specified target number [fx,indexbord,#,frames]
						var getamt = real_ext(len > 1 ? param[1] : sprite_get_number(spr_bord) - 1), time_ = real_ext(len > 2 ? param[2] : "30");
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 30}", "bord_index>", getamt == "" ? sprite_get_number(spr_bord) - 1 : getamt); delayfunc();
					} break;
					case "rotate": case "rot": case "angle": { //Make the face rotate to the specified target number [effect,rotate,#,frames,issmooth]
						var getamt = real_ext(len > 1 ? param[1] : "359"), time_ = real_ext(len > 2 ? param[2] : "30"), smooth_ = real_ext(len > 3 ? param[3] : "0"); smooth_ = smooth_ != "" ? bool(smooth_) : false;
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 30}", $"~{!smooth_? "linear" : "oquad"}", "dial_face_angle>", getamt != "" ? getamt : 0); delayfunc();
					} break;
					case "scale": case "size": { //Make the face scale to the specified target number [effect,scale,#,#,frames,issmooth]
						var getamt = real_ext(len > 1 ? param[1] : "0"), getamt2 = real_ext(len > 2 ? param[2] : "0"), time_ = real_ext(len > 3 ? param[3] : "30"), smooth_ = real_ext(len > 4 ? param[4] : "0"); smooth_ = smooth_ != "" ? bool(smooth_) : false;
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 30}", $"~{!smooth_? "linear" : "oquad"}", "dial_face_xscale_off>", getamt != "" ? getamt : 0, "dial_face_yscale_off>", getamt2 != "" ? getamt2 : 0); delayfunc();
					} break;
					case "slide": case "move": case "xy": { //Make the face slide to the specified target number [effect,slide,#,#,frames,issmooth]
						var getamt = real_ext(len > 1 ? param[1] : "0"), getamt2 = real_ext(len > 2 ? param[2] : "0"), time_ = real_ext(len > 3 ? param[3] : "30"), smooth_ = real_ext(len > 4 ? param[4] : "0"); smooth_ = smooth_ != "" ? bool(smooth_) : false;
						TweenFire("?", obj_system, $"${time_ != "" ? time_ : 30}", $"~{!smooth_? "linear" : "oquad"}", "dial_face_xoff>", getamt != "" ? getamt : 0, "dial_face_yoff>", getamt2 != "" ? getamt2 : 0); delayfunc();
					} break;
					case "shake": case "rumble": { //Make the shake in place for some time [effect,shake,x,y,frames,intensity]
						var x_ = real_ext(len > 1 ? param[1] : "0"), y_ = real_ext(len > 2 ? param[2] : "0"), time_ = real_ext(len > 3 ? param[3] : 5), off_ = real_ext(len > 4 ? param[4] : 2)
						 x_ = x_ != "" ? bool(x_) : false; y_ = y_ != "" ? bool(y_) : false; time_ = time_ == "" ? 5 : time_; off_ = off_ == "" ? 2 : off_;
						TweenScript(SYSTEMUI, 0, time_, function() { soup_checkout("face shaker"); dial_face_xoff = 0; dial_face_yoff = 0; });
						soup_store("face shaker", { x_, y_, time_, off_ }); delayfunc();
					} break;
				}
			}
			scribble_typists_add_event("effect", efxfunc); scribble_typists_add_event("fx", efxfunc);
		#endregion
		
		#region Macros
			scribble_add_macro("icon", function(param, index_ = 0, spd_ = 1) { var result = get_icon(param) return result != -1 ? $"[{result},{index_},{spd_}]" : ""; }); //Icon helper tag [icon,funnytext game over]
			scribble_add_macro("face_spr", function(name_, expression_ = -1, index_ = 0, spd_ = 1) { var result = get_face(name_, expression_) return result != -1 ? $"[{result},{index_},{spd_}]" : ""; }); //Icon helper tag [face_spr,toriel happy]
			scribble_add_macro("newlp", function() { return "\n  "; }); //Newline with no asterisk and it's padded out
			scribble_add_macro("newla", function() { return "\n* "; }); //Newline with asterisk and a space
			scribble_add_macro("newl", function() { return chr(10); }); //Newline literal
			scribble_add_macro("pg", function() { return "[/page]"; }); //Page shorthand
			scribble_add_macro("wait", function(param = 1) { var real_ = real_ext(param); return $"[delay,{real_ != "" ? real_  * 1000 : 0}]"; }); //Delay tag that converts seconds to milliseconds [wait,1] 
			scribble_add_macro("repeat", function(phrase_ = "", times_ = 1, startwith_ = "", endwith_ = "") { //Repeats a phrase for a specified time with an optional parameter to end and start it off with another phrase [repeat,phrase,times,startwith,endwith]
				var real_ = string_digits(times_); if ( real_ == "" ) { return ""; }
				var string_ = "";
				string_ += startwith_; repeat ( real_ ) { string_ += phrase_; } string_ += endwith_;
				return string_;
			});
			scribble_add_macro("test", function(param) { //Various stress tests and testing suites
				switch ( param ) {
					//Stress test the typewriter gif export
					case "fullpage": { return "[repeat,s,96][newl][/page][c_red][repeat,o,96][newl][/page][c_gold][repeat,u,96][newl][/page][/][rainbow][repeat,p,96][newl][/page][/][shake][face,spr_toriel_mortified][repeat,y,72][face_stick]"; break; }
					//Tests various dialogue portrait effects
					case "soupy": { return "[face,soupy happy][fx,ghost,0,0][fx,ghost,1][fx,move,-20,,0][fx,move,,,,1]There's an option to [c_cyan][slant]hide the dialogue box[/slant][/] if you just want the[face_stick_all][skip][newl][/page]typewriter text.[/page]Very useful for [wheel]UTDR animations![/wheel][delay][newl][face,soupy goodjob][fx,squeeze][shake]I'm so soupyyy!![face_stick]"; break; }
					//Test the various funnytext
					case "funnytext": { return "[scale,0.65][icon,funnytext game over][wait,3][newl][/page][scale,0.5][spr_dw_tv_time_its][delay]  [spr_dw_tv_time_t][delay][offset,-50,15][spr_dw_tv_time_v][offsetPop][delay][offset,-30][spr_dw_tv_time_time][delay][newl][/page][scale,0.6][icon,funnytext dark fountain][wait,3][newl][/page][scale,0.65][spr_funnytext_physical_challenges][wait,3][newl][/page][scale,1.3][funnytext_tears][wait,3][newl][/page][scale,1.3][spr_funnytext_win][wait,3][newl][/page][scale,0.4][spr_funnytext_win_big][wait,3][newl][/page][scale,1.45][spr_funnytext_flames][wait,3]"; break; }
					//Test all the effects
					case "effects": { return "[wave]Wavy text.[/wave] [wheel]Wheel text.[/wheel] [shake]Shaky text.[/shake] [wobble]Wobbly text.[/wobble] [pulse]Pulse text.[/pulse] [rainbow]Rainbow text.[/rainbow] [slant]Slanted text.[/slant][newl][/page][scale,0.5]Scaled text.[/scale] [cycle,70,150]Color cycling text.[/cycle] [blink]Blink text.[/blink] [alpha,0.5]Different alpha.[/alpha][newl][/page][speed,4]Speedy text test: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"; break; }
					//Test dialogue stacking
					case "stack": { return "[repeat,test[newl][/page]test2[newl][/page]test3[newl][/page]test4[newl][/page]test5[newl][/page]test6[newl][/page]test7[newl][/page]test8[newl][/page]test9,5]"; break; }
					//Test overloading the dialogue stack
					case "overload": { return "[test,stack][/page][test,stack]"; break; }
					//Test dialogue choices
					case "choicer": { return "[choicer,Test Option,Test Option 2,Test Option 3,Test Option 4][newl][wait,2][newl][choicer_on,1][wait][newl][choicer_on,2][wait][newl][choicer_on,3][wait][newl][choicer_on,4][wait,2][newl][choicer_on,0][wait]"; break; }
					
					case "basic": { return "Test text 1, 2, 3.[newl]Test text 4, 5, 6.[newl]Test text 7, 8, 9.[/page][c_red]Test text 1, 2, 3.[newl]Test text 4, 5, 6.[newl]Test text 7, 8, 9."; break; }
					default: { return "Testing suite ID not found."; }
				}
			});
			
			var func_ = function(m_ = "") { return global.pref.macros[$ m_] ?? ""; } //Return a macro from the global preference macro struct
			scribble_add_macro("macro", func_); scribble_add_macro("mac", func_); scribble_add_macro("mc", func_); 
		#endregion
	#endregion
#endregion

#region Dialogue Choice
	dial_choices = ["", "", "", ""]; //Available dialogue choices
	dial_choices_ico = spr_soul; //Chooser indicator
	dial_choices_ico_index = 0; //Image index
	dial_choices_ico_xs = 1; //Image xscale
	dial_choices_ico_ys = 1; //Image yscale
	dial_choices_ico_angle = 0; //Image angle
	dial_choices_ico_clr = c_white; //Image blend
	dial_choices_menu = 0; //Current selected option
	dial_choices_scaleoff = 0; //Scaling animation
	dial_choices_deltarunelike = false; //Whether to make the choicer act more like Deltarune's choicer
#endregion

#region Dialogue Shadow
	dial_text_shdw = false; //Whether text should have a shadow
	dial_text_shdw_clr = c_deltarune; dial_text_shdw_clr_orig = dial_text_shdw_clr; //Shadow Color
	dial_text_shdw_clr_g = make_color_rgb(36, 36, 36); dial_text_shdw_clr_g_orig = dial_text_shdw_clr_g; //Shadow gradient color
	dial_text_shdw_x = 1; dial_text_shdw_x_orig = 1; //Shadow x offset
	dial_text_shdw_y = 1; dial_text_shdw_y_orig = 1; //Shadow y offset
#endregion

#region Dialogue Face
	dial_face[dial_text_page] = -1; //Dialogue Face
	dial_face_index[dial_text_page] = 0; //Dialogue Face Frame
	dial_face_prev[dial_text_page] = -1; //Previous Dial Face
	dial_face_original[dial_text_page] = -1; //Original Dial Face
	dial_face_auto = true; //Whether to automatically animate the sprite when dialogue is typing
	dial_face_spd[dial_text_page] = 0; //Dialogue face speed
	dial_face_clr = c_white; //Dialogue Face Clr
	dial_face_name[dial_text_page] = -1; //Dialogue Portrait Internal Name
	dial_face_keep = true; //Whether to always keep the last dialogue face or reset back to the original face
	dial_face_xscale = 2; dial_face_yscale = 2; //Dialogue Face Xscale & Yscale
	dial_face_xscale_off = 0; dial_face_yscale_off = 0; //Dialogue Face Xscale & Yscale offset, for animation
	dial_face_angle = 0; //Dialogue Face Rotation
	dial_face_alpha = 1; //Dialogue Face Alpha
	dial_face_xoff = 0; dial_face_yoff = 0; //Dialogue Face X & Y offset, for animation
	dial_face_xoff_static = 0; dial_face_yoff_static = 0; //Dialogue Face X & Y offset not for animation
	dial_face_xoff_static_orig = 0; dial_face_yoff_static_orig = 0;
	dial_face_anim = 2; //How many letters should pass before animating the face?
	
	dial_face_alpha_orig = dial_face_alpha;  //Original alpha to revert back to
	dial_face_angle_orig = dial_face_angle;  //Original angle to revert back to
#endregion

ui_init();

#region Error Handling
	errname = $"{directory_get_temporary_path()}error_log.soupy";

	if ( !is_android() ) {
		exception_unhandled_handler(function(err_) {
			var errlog = $"Error: {err_.longMessage}\nStack Trace: {err_.stacktrace}";
			show_debug_message($"--------------------------------------------------------------\nAn error has occured: {errlog}\n--------------------------------------------------------------\n\n");
			
			//Write the exception struct to a file
			var buff = buffer_create(string_byte_length(errlog), buffer_grow, 1); //Create a buffer with the size of the error message string, fixed with an aligment of 1
			buffer_write(buff, buffer_text, errlog); //Save the json to the new buffer..
			buffer_save(buff, errname); //Save the buffer to a new file of specified name
			buffer_delete(buff); //Delete buffer to prevent memory leaks
		
			game_restart_alt();
		});
	}
#endregion

#region First Time
	var txt_ = $"Ayy! Welcome to [wheel][c_gold]UTDR SoupGen![/]|I see that it's your first time booting this up.|I would recommend [c_yellow]reading the[c_yellow] help guide before you continue[/].||SoupGen got a [slant]lot[/] of power to it compared|to your average UTDR textbox generator,|so do familarize yourself with what all you can do!| |With that being said, [wave][c_lime]I hope you enjoy|this release!|Once you're done, just press ESC for export options!{is_android() ? "| |You're using the Android version!|SoupGen was not optimized for phones,|but plenty of work has gone into making the experience similar|to PCs. You may still struggle in some places tho, sorry!||You will now be asked where to let SoupGen store files at.|I recommend your Pictures folder." : ( is_wasm() ? "| |You're using the experimental WASM(Web) version!|SoupGen was NOT optimized for the web.|See the known issues in the description." : "" )}";
	
	save_pref = function () {
		var data_ = json_stringify(global.pref);
		var buff_ = buffer_create(string_byte_length(data_), buffer_fixed, 1);
		buffer_write(buff_, buffer_text, data_); buffer_save(buff_, PREF_SOUP); buffer_delete(buff_);
	}
	
	save_preset = function (label_ = "") {
		global.pref.presets[$ label_] = {
			//Borders
			spr_bord, bord_name, bord_clr, bord_index, bord_spd, bord_anim, bord_anim_track, bord_scale, bord_stretch, bord_xoff, bord_yoff, bord_angle, bord_prev,
			
			//Text
			dial_font, dial_text_scale, dial_text_c, dial_text_outline, dial_point_chr, dial_point_clr, dial_point_clr_anim, dial_point_clr_anim_alpha, dial_text_line_spacing, dial_text_xoff, dial_text_yoff, dial_text_halign, dial_text_valign, dial_rtl, dial_gradient,
			dial_gradient_clr, dial_indicator, dial_indicator_index,dial_indicator_spd, dial_indicator_anim, dial_indicator_visible, dial_indicator_scale, dial_indicator_xoff, dial_indicator_yoff, dial_indicator_angle, dial_indicator_blink,
			typist_spd, typist_smooth, typist_ease, dial_gradient_orig, dial_gradient_clr_orig, dial_glow, dial_glow_clr, dial_glow_time,
			
			//Shadow
			dial_text_shdw, dial_text_shdw_clr, dial_text_shdw_clr_g, dial_text_shdw_x, dial_text_shdw_y,
			
			//Face
			dial_face_clr, dial_face_xscale, dial_face_yscale, dial_face_angle, dial_face_alpha, dial_face_xoff_static, dial_face_yoff_static, dial_face_anim, dial_face_angle_orig, dial_face_alpha_orig,
		};
	}
	
	var save_ = function () {
		global.pref.firsttime = false;
		SYSTEMUI.save_pref();
		soupy_url("https://rentry.co/utdrsoupguides", , , 0);
		if ( is_android() ) {
			var perm_r = "android.permission.READ_EXTERNAL_STORAGE", perm_w = "android.permission.WRITE_EXTERNAL_STORAGE";
			if ( os_check_permission(perm_r) == os_permission_denied || os_check_permission(perm_w) == os_permission_denied ) { os_request_permission(perm_r, perm_w); }
			android_path = intent_saf_request(SAF_REQUEST_SEARCH_DIRECTORY, SAF_MIME_TYPE_IMAGE); 
		}
	}
	
	if ( global.pref.firsttime ) { var id_ = soupy_message(txt_, "Let's get soupy!", 480, , , snd_dimbox, fnt_abaddon, save_, , true, , , fa_top); soup_store("firsttime", id_, , true); }
#endregion

#region Errors with Auto-loading
	external_error();
#endregion