///@desc Bulk Load Faces
//if ( live_call() ) { return live_result; }
var get_ = async_load, info_ = soup_checkout("bulkload", , true);
if ( !is_undefined(info_) && get_[?"id"] == info_.id ) {
	if ( get_[?"status"] == 0 ) { //Successfully unzipped!
		sfx_play(snd_dimbox);
		var files_ = gumshoe(info_.finalpath, ".png");
		var i = 0, len = array_length(files_);
		repeat ( len ) {
			var faces_cur = files_[i]; //Current face path we're looking at
			var faces_dir = filename_dir_name(faces_cur); //Get directory name
			if ( faces_dir != "" && faces_dir != string_replace(info_.fname, ".zip", "") ) { //Not trying to load a file outside a folder
				if ( !struct_exists(global.faces_dict, faces_dir) ) { global.faces_dict[$ faces_dir] = {}; } //Create new struct face dictionary
				var temp_ = string_replace(faces_cur, filename_path(faces_cur), ""); //Remove faces/(folder name)/
				var imgnum = string_between(temp_, "_strip", ".png"); imgnum = imgnum == "" ? 1 : real(imgnum); //Get the image number if it's a strip file
				var faces_emote = string_exclude(string_replace(string_replace(string_replace(temp_, $"_strip", ""), $"spr_{faces_dir}_", ""), ".png", ""), "1234567890"); //Get face expression
				if ( faces_emote != "" ) { //Filename isn't just numbers
					with ( global.faces_dict[$ faces_dir] ) {
						if ( is_undefined(self[$ faces_emote]) ) { //If this dictonary doesn't already exist
						self[$ faces_emote] = { sprite: sprite_add(faces_cur, imgnum, false, false, 0, 0), expression: faces_emote, name: faces_cur, count: imgnum, } //Add sprite index and expression name to the global face dictonary
							with ( self[$ faces_emote] ) { 
								self[$ "destroy"] = function () { sprite_delete(sprite); delete sprite; sprite = -1; show_debug_message($"External face \"{name}\" was destroyed and freed from memory successfully!"); } //Add a destroy func so we don't get memory leaks
								self[$ "size"] = { sprite, width: sprite_get_width(sprite), height: sprite_get_height(sprite), }
								sprite_set_offset(sprite, size.width/ 2, size.height/ 2); //Center sprite
					
								var scrib_ = $"{faces_dir}_{expression}"; scribble_external_sprite_add(sprite, scrib_); //Register sprite with Scribble
								var altname_ = $"spr_{scrib_}"; if ( !scribble_external_sprite_exists(altname_) ) { scribble_external_sprite_add(sprite, altname_); } //Alternative name
								global.faces_dict_alt[$ altname_] = { sprite, name: altname_, destroy, size } //Add sprite index and expression name to the global face alt dictonary
								var out_ = $"Added \"{expression}\" from {name}! | Image number: {count} | Scribble name: {scrib_} | Scribble alt name: {altname_}";
								show_debug_message(out_); audio_stop_sound(snd_updated); sfx_play(snd_updated);
								file_copy(faces_cur, $"{executable_get_directory()}faces{PATHSEP}{faces_dir}{PATHSEP}{string_replace(faces_cur, filename_path(faces_cur), "")}");
							}
						}
						else { 
							var out_ = $"|Tried to load a sprite that already exists|({filename_name(faces_cur)})! Skipped...|Remove duplicates before trying again!|";
							show_debug_message(out_); global.outputLogSkipped += out_; 
						}
					}
				}
				else { 
					var out_ = $"|Tried to load a sprite with an invalid filename|({filename_name(faces_cur)})! Skipped...|Make sure you properly name your files! (No numbers besides _stripN.png)|";
					show_debug_message(out_); global.outputLogSkipped += out_; 
				}
			}
			else { 
				if ( !is_android() ) {
					var out_ = $"|Tried to load a sprite outside of a folder|({filename_name(faces_cur)})! Skipped...|Face sprites for auto-loading should have all their faces in their own folders!|";
					show_debug_message(out_); global.outputLogSkipped += out_; 
				}
			}
		i++; }
		
		external_error();
	}
	else {
		sfx_play(snd_error);
		var out_ = "|Couldn't extract zip contents.|Possibly corrupted or password-locked?";
		global.outputLogSkipped += out_;
		external_error();
	}
}
