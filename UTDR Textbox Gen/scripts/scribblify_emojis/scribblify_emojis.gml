function scribblify_emojis(input_string, _sprite, _lookup_table) {
	#region Set up Optimizers
	static read_buff = buffer_create(0, buffer_grow, 1);
	static emoji_buff = buffer_create(0, buffer_grow, 1);
	static input_buff = buffer_create(0, buffer_grow, 1);
	static output_buff = buffer_create(0, buffer_grow, 1);
	
	static __cache = {};
	
	//micro optimization
	var _read_buff = read_buff;
	var _emoji_buff = emoji_buff;
	var _input_buff = input_buff;
	var _output_buff = output_buff;
	
	// Pre-allocate sizes
	var _byte_len = string_byte_length(input_string);
	buffer_resize(_input_buff, _byte_len)
	buffer_resize(_output_buff, _byte_len)
	
	// Write input buffer
	buffer_write(_input_buff, buffer_text, input_string);
	buffer_seek(_input_buff, buffer_seek_start, 0)
	
	#endregion
	
	//People will forget to call the function, we can just handle it for them since it's really just a name space
	if (is_callable(_lookup_table)) {
		_lookup_table = _lookup_table();
	}
	if (!is_struct(_lookup_table)) {
		throw $"Lookup table is not a struct :: {typeof(_lookup_table)} :: {_lookup_table}"
	}
	
	// Constants
	var __ZeroWidthJoiner = 0x200D; // used to combine two emojis together
	var __VariationSelector = 0xFE0F; //usually used for alternate emoji drawing, or drawing a regular char as an emoji
	var __SkinTonesMin = 0x1F3FB; // The lower end of the skin tones
	var __SkinTonesMax = 0x1F400; // The upper end of the skin tones
	
	// Variables
	var _sprite_name = sprite_get_name(_sprite);
	
	// Convert raw lookup tables (rect structs) into Scribble format tags once.
	// __lt_* scripts return { "emoji": {x,y,w,h}, ... } — we need { "emoji": "[texture,...]", ... }.
	var _tag_table = __cache[$ _sprite_name];
	if (_tag_table == undefined) {
		_tag_table = __emj_build_format_tags_for_lookup_table(_lookup_table, _sprite_name);
		__cache[$ _sprite_name] = _tag_table;
	}
	
	//used for keeping track of the last found replacement
	var _previous_codepoint = undefined;
	var _codepoint = undefined;
	
	while (buffer_tell(_input_buff) < _byte_len) {
		_codepoint = __emj_buffer_read_codepoint(_input_buff);

		if (is_emoji_codepoint(_codepoint)) {
			//not needed as resizing it at the end will handle this for us
			///buffer_seek(_emoji_buff, buffer_seek_start, 0);

			// Include previous codepoint if it's a variation
			if (_previous_codepoint != undefined) {
				if (_codepoint == __VariationSelector) {
					__emj_buffer_write_codepoint(_emoji_buff, _previous_codepoint);
				}
				else {
					__emj_buffer_write_codepoint(_output_buff, _previous_codepoint);
					_previous_codepoint = undefined;
				}
			}

			// Collect full emoji sequence
			var _reach_eob = false; //reached end of buffer
			while (is_emoji_codepoint(_codepoint)) {
				//show_debug_message($"Added codepoint :: {_codepoint} :: '{chr(_codepoint)}'")
				__emj_buffer_write_codepoint(_emoji_buff, _codepoint);
				if (buffer_tell(_input_buff) >= _byte_len) {
					_reach_eob = true;
					break;
				}
				_codepoint = __emj_buffer_read_codepoint(_input_buff);
			}

			var emoji_len = buffer_tell(_emoji_buff);
			var read_pos = 0;
			//show_debug_message($"searching for emojis :: emoji_len = {emoji_len}, read_pos = {read_pos}")
			// Match longest substrings first
			while (read_pos < emoji_len) {
				var matched = false;

				for (var length = emoji_len - read_pos; length > 0; length--) {
					//show_debug_message(length)
					//read the text of the emoji
					buffer_copy(_emoji_buff, read_pos, length, _read_buff, 0);
					var _candidate = buffer_read(_read_buff, buffer_text);
					//show_debug_message(_candidate)
					buffer_resize(_read_buff, 0);
					
					show_debug_message($"Attempting to find _candidate :: '{_candidate}' :: {struct_exists(_tag_table, _candidate)}")
					
					if (_tag_table[$ _candidate] != undefined) {
						//show_debug_message($"Found _candidate :: '{_candidate}' == {_tag_table[$ _candidate]}")
						var _replacement = _tag_table[$ _candidate];
						buffer_write(_output_buff, buffer_text, _replacement);

						read_pos += length;
						matched = true;
						break;
					}
				}

				if (!matched) {
					//show_debug_message($"matched no emojis")
					var cp = buffer_peek(_emoji_buff, read_pos, buffer_u8);
					buffer_write(_output_buff, buffer_u8, cp);
					read_pos += 1;
				}
			}
			
			buffer_resize(_emoji_buff, 0)
			
			//if end of buffer, break.
			if (_reach_eob) {
				break;
			}
			
			_previous_codepoint = _codepoint;
			_codepoint = undefined;
		}
		else {
			if (_previous_codepoint != undefined) {
				__emj_buffer_write_codepoint(_output_buff, _previous_codepoint);
			}
			_previous_codepoint = _codepoint;
			_codepoint = undefined;
		}
	}

	// Final replacement in case we end on a valid match
	if (_previous_codepoint != undefined) {
		__emj_buffer_write_codepoint(_output_buff, _previous_codepoint);
	}
	
	// Convert buffer back to string
	buffer_seek(_output_buff, buffer_seek_start, 0);
	var result = buffer_read(_output_buff, buffer_text);
	
	#region Clean up Optimizers
	buffer_resize(_input_buff, 0);
	buffer_resize(_output_buff, 0);
	#endregion
	
	return result;
}