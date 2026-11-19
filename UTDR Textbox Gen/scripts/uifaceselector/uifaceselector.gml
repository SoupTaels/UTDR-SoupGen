function loadfaces(element_, check_ = false) { //Once clicked on, create new scroll panel and populate it with face sprites
	if ( check_ ) { var last_ = soup_checkout("lastface", false, true); if ( last_ ==  element_.params.id_ ) { soup_checkout("lastface", , true); } else exit; }
	var get_ = soup_checkout("scrollmain", false); soup_checkout("scrollsub", false).destroy(); soup_checkout("metadata");
	global.faces_dict[$ element_.params.id_][$ "NEW SPRITE"] = false; sfx_play(snd_select);
	//Exit early if the sprite already exists(for external sprites added through drag & drop)
	var early_ = get_face(element_.params.id_); if ( sprite_exists(early_) ) { sfx_play(snd_updated); if ( element_.getData("clear_") ) { FACE_CURRENT = early_; FACE_ORIGINAL = FACE_CURRENT; } soup_checkout(element_.getData("inputsoup_"), false, element_.getData("inputglobal_")).set(element_.params.id_); soup_checkout(element_.getData("imagesoup_"), false, element_.getData("imageglobal_")).set(early_); soup_checkout("datafunc", false)(); exit; }
					
	var spr_ = [], cur_ = element_.getData("chara"), spr_exp = struct_get_names(global.faces_dict[$ cur_]), spr_len = array_length(spr_exp), spr_i = 0; //Folders filled with sprites will have their sprites shown here
	repeat ( spr_len ) {
		var exp_ = spr_exp[spr_i], finalname = $"spr_{cur_}_{exp_}", myspr = get_face(finalname);
		if ( exp_ != "NEW SPRITE" ) {
			#region Metadata
				if ( !is_undefined(global.faces_dict_meta[$ cur_]) && !soup_store_undefined("metadata") ) {
					var mdata_ = global.faces_dict_meta[$ cur_], str_ = $"\nNote: {mdata_.note}";
					array_push(spr_, 
						new LuiText({ value: $"Author: {mdata_.author}", color: c_white, text_halign: fa_center, text_valign: fa_middle, font: fnt_speech, auto_size: false, }).setWidth(200).setTooltip($"[rainbow]{mdata_.page}[/]{mdata_.note == "" ? "" : str_ }", true, , true, 600).setData("link", mdata_.page)
							.addEvent(LUI_EV_MOUSE_ENTER, function(element_) { element_.color = c_lime; sfx_play(snd_sel_switch); element_.main_ui.animate(element_, "xoff", 10, 0.30, global.Ease.OutBack, 0); })
							.addEvent(LUI_EV_MOUSE_LEAVE, function(element_) { element_.color = c_white; element_.main_ui.animate(element_, "xoff", 0, 0.15); })
							.addEvent(LUI_EV_CLICK, function(element_) { sfx_play(snd_equip); soupy_url(element_.getData("link")); })
					);
					soup_store("metadata");
				}
			#endregion
			array_push(spr_, new LuiImageButton({ value: myspr, draw_normal: true, }).setSize(sprite_get_width(myspr), sprite_get_height(myspr)).setData("face", myspr).setData("facename", finalname).setFlexAlignSelf(flexpanel_align.center).setTooltip($"{finalname}\n[face,{finalname}]", true)
			.setData("inputsoup_", element_.getData("inputsoup_")).setData("inputglobal_", element_.getData("inputglobal_")).setData("imagesoup_", element_.getData("imagesoup_")).setData("imageglobal_", element_.getData("imageglobal_")).setData("clear_", element_.getData("clear_"))
			.addEvent(LUI_EV_CLICK, function(element_) { soup_store("lastface", string_between(element_.getData("facename"), "spr_", "_"), , true); sfx_play(snd_updated); if ( element_.getData("clear_") ) { FACE_CURRENT = element_.getData("face"); FACE_ORIGINAL = FACE_CURRENT; FACE_INTERNAL = element_.getData("facename"); } soup_checkout(element_.getData("inputsoup_"), false, element_.getData("inputglobal_")).set(element_.getData("facename")); soup_checkout(element_.getData("imagesoup_"), false, element_.getData("imageglobal_")).set(element_.getData("face")); soup_checkout("datafunc", false)(); })
			.addEvent(LUI_EV_MOUSE_ENTER, function(element_) { if ( sprite_get_number(element_.get()) > 1 ) { element_.imgspd = 0.15; } }).addEvent(LUI_EV_MOUSE_LEAVE, function(element_) { element_.imgspd = 0; element_.subimg = 0; })
			);
		}
	spr_i++; }
					
	#region Sort Names Alphabetically
		array_sort(spr_, function(arrcur_, arrnext_) {
			if ( string_lower(arrcur_.value) < string_lower(arrnext_.value) ) { return -1; }
			else if ( string_lower(arrcur_.value) > string_lower(arrnext_.value) ) { return 1; }
			else { return 0; }
		});
	#endregion
	get_.addContent(new LuiScrollPanel({ height: 400, scroll_pin_edge_offset:10, sprite_panel: false, sound_right: snd_throw, }).addContent(new LuiRow().setFlexJustifyContent(flexpanel_justify.space_around).setFlexWrap(1).addContent(spr_)).addEvent(LUI_EV_CREATE, function(element_) { soup_store("scrollsub", element_); })); //Add new panel and stash it so we can destroy it later
}
						
function checkfaces(element_) { TweenScript(SYSTEMUI, , 1.2, loadfaces, element_, true); }