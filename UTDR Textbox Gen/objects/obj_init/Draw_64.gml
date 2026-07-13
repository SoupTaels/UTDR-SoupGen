///@desc 
draw_format("center", "center", fnt_speech, c_gold);
draw_text_transformed(320, 240, $"Loading {loading_text}...", 2, 2, 0);
if ( loading_state >= 4 ) {
	draw_sprite_ensure(spr_sosoupy, 0, 320, 340, 2, 2);
}