///@desc 
loading_state = 0;
loading_text = "dialogue portraits";
loading_func = function() {
	sfx_play(snd_bump, , , random_range(0.7, 1.3));
	switch ( loading_state ) {
		case 0: { load_faces(); break; }
		case 1: { load_borders(); break; }
		case 2: { load_icons(); break; }
		case 3: { load_ref(); break; }
		case 4: { load_fonts(); break; }
		case 5: { EmobbleInit(); room_goto_next(); break; }
	}
}
alarm[0] = 5;