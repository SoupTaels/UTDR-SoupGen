// Give a literal reference to the font and bullet point sprite so they are included in the compile.
// There is a pending Pull request for Scribble currently by Tabularelf which will resolve the need for this
// https://github.com/JujuAdams/Scribble/pull/613
var scribble_include_in_compile_fnt = scribble_fallback_font;
var scribble_include_in_compile_spr = scribble_fallback_bulletpoint;

function EmobbleInit() {
	//Define a new default font
	var _scribble_default_font = scribble_font_get_default();
	scribble_super_create("EmobbleDefaultOverwrite")
	scribble_super_glyph_copy_all("EmobbleDefaultOverwrite", _scribble_default_font, true)
	scribble_super_glyph_copy_all("EmobbleDefaultOverwrite", font_get_name(EMOBBLE_ATLAS_FONT), false)
	scribble_font_set_default("EmobbleDefaultOverwrite")

	//This will set the default preprocessor scribble uses to convert emojis for you.
	scribble_default_preprocessor_set(__emobble_preprocesser);
	
	
	scribble_add_macro("emoji", function(_emoji_name) {
		var _emoji_str = emobble_get_emoji(_emoji_name);
		var _string = __emobble_preprocesser(_emoji_str)
		return _string;
	})
	
}

function __emobble_preprocesser(_string) {
	_string = scribblify_emojis(_string, EMOBBLE_ATLAS_SPRITE, EMOBBLE_ATLAS_LOOKUP)
	return _string;
}
