function is_emoji_codepoint(_codepoint) {
    return (
		(_codepoint >= 0x0600) || //honestly anything past hebrew is probably fine
		(_codepoint >= 0x1F300 && _codepoint <= 0x1F9FF) || // Standard emoji range
        (_codepoint >= 0x2600 && _codepoint <= 0x26FF) ||   // Misc symbols that can be emoji
        (_codepoint == 0x200D) || // Zero Width Joiner
        (_codepoint == 0xFE0F)    // Variation Selector
    );
}

function __emj_buffer_read_codepoint(_buff) {
    var byte1 = buffer_read(_buff, buffer_u8);
	
	// 1-byte (ASCII)
    if (byte1 < 0x80) {
        return byte1;
    } 
	// 2-byte UTF-8
    else if ((byte1 & 0xE0) == 0xC0) {
        return ((byte1 & 0x1F) << 6)
				| (buffer_read(_buff, buffer_u8) & 0x3F);
    } 
	// 3-byte UTF-8
    else if ((byte1 & 0xF0) == 0xE0) {
        return ((byte1 & 0x0F) << 12)
				| ((buffer_read(_buff, buffer_u8) & 0x3F) << 6)
				| (buffer_read(_buff, buffer_u8) & 0x3F);
    } 
    // 4-byte UTF-8
	else if ((byte1 & 0xF8) == 0xF0) {
        return ((byte1 & 0x07) << 18)
				| ((buffer_read(_buff, buffer_u8) & 0x3F) << 12)
				| ((buffer_read(_buff, buffer_u8) & 0x3F) << 6)
				| (buffer_read(_buff, buffer_u8) & 0x3F);
    }

    return 0; // Invalid sequence
}

function __emj_buffer_write_codepoint(_buffer, _codepoint) {
    if (_codepoint <= 0x7F) {
        buffer_write(_buffer, buffer_u8, _codepoint);
    }
    else if (_codepoint <= 0x7FF) {
        buffer_write(_buffer, buffer_u8, 0xC0 | (_codepoint >> 6));
        buffer_write(_buffer, buffer_u8, 0x80 | (_codepoint & 0x3F));
    }
    else if (_codepoint <= 0xFFFF) {
        buffer_write(_buffer, buffer_u8, 0xE0 | (_codepoint >> 12));
        buffer_write(_buffer, buffer_u8, 0x80 | ((_codepoint >> 6) & 0x3F));
        buffer_write(_buffer, buffer_u8, 0x80 | (_codepoint & 0x3F));
    }
    else {
        buffer_write(_buffer, buffer_u8, 0xF0 | (_codepoint >> 18));
        buffer_write(_buffer, buffer_u8, 0x80 | ((_codepoint >> 12) & 0x3F));
        buffer_write(_buffer, buffer_u8, 0x80 | ((_codepoint >> 6) & 0x3F));
        buffer_write(_buffer, buffer_u8, 0x80 | (_codepoint & 0x3F));
    }
}

function __emj_build_format_tags_for_lookup_table(_lookup, _sprite_name){
	//fetch uv coords
	var _sprite = asset_get_index(_sprite_name);
		
	if (!sprite_exists(_sprite)) {
		__scribble_trace($"Emoji Module :: Sprite resource '{_sprite_name}' is missing from project. This may indicate that unused assets have been stripped from the project\nPlease untick \"Automatically remove unused assets when compiling\" in Game Options")
	}
	
	var _tex_id = sprite_get_info(_sprite).frames[0].texture;
	var _tex_uv = sprite_get_uvs(_sprite, 0);
		
	var _tex_tw = texture_get_texel_width(_tex_id);
	var _tex_th = texture_get_texel_height(_tex_id);
		
	var _tex_l = _tex_uv[0]/_tex_tw;
	var _tex_t = _tex_uv[1]/_tex_th;
	
	var _output = {};
	
	var _keys = struct_get_names(_lookup);
	var _i=0; repeat(array_length(_keys)) {
		var _key = _keys[_i];
		var _struct = _lookup[$ _key];
		
		_output[$ _key] = $"[texture,{_tex_id},{_tex_l+_struct.x},{_tex_t+_struct.y},{_struct.w},{_struct.h}]";
	_i++}
	return _output;
}