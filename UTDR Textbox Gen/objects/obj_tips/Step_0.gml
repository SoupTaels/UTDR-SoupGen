if ( !UI_MESSAGE ) { exit; }
if ( range_within(mouse_x_gui, bbox_left - 10, bbox_right + 10) && range_within(mouse_y_gui, bbox_top - 10, bbox_bottom + 10) ) {
	image_xscale = lerp(image_xscale, 1.5, 0.30);
	image_yscale = image_xscale;
	if ( !hover ) { hover = true; image_blend = c_yellow; sfx_play(snd_sel_switch); }
	if ( mouse_pressed_right ) { instance_destroy(); sfx_play(snd_hurtpowerful); exit; }
	if ( mouse_pressed ) { 
		sfx_play(snd_select);
		soupy_message(txt, "Huh, neat!", , , , snd_dimbox, fnt_abaddon, , , true);
		instance_destroy(); exit;
	}
}
else {
	image_xscale = lerp(image_xscale, 1, 0.30);
	image_yscale = image_xscale;
	if ( hover ) { hover = false; image_blend = c_white; }
}