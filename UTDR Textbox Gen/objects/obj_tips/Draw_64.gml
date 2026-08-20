///@desc 
if ( !UI_MESSAGE ) { exit; }
soupyclipm_begin_clip();
	draw_sprite_ext(spr_pixel, 0, 1, 1, 36, 36, 0, c_white, 1);
soupyclipm_end_clip();
							
soupyclipm_draw();
	draw_sprite_stretched_ext(spr_border_undertale_outlined, 0, -36, -36, 72, 72, image_blend, image_alpha);
shader_reset();

draw_self();