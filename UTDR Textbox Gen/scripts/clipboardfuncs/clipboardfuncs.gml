///@desc Sends a surface's image data to the clipboard
///@param {surface} surf Surface ID
function clipboard_set_surface(surf) {
	if ( !surface_exists(surf) ) { exit; }
	var w = surface_get_width(surf), h = surface_get_height(surf), buff = buffer_create(w * h * 4, buffer_fixed, 1);
	var temp = surface_create(w, h);
	
	
	surface_set_target(temp);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	shader_set(shd_bgr);
		draw_clear_alpha(c_black, 0);
		draw_surface(surf, 0, 0);
	gpu_set_blendmode(bm_normal); gpu_set_blendequation(bm_eq_add);
	surface_reset_target();
	shader_reset();
	
	buffer_get_surface(buff, temp, 0);
	clipboard_set_bitmap(buffer_get_address(buff), w, h);
	buffer_delete(buff); surface_free(temp);
}

///@desc Sends a sprite's image data to the clipboard.
function clipboard_set_sprite(spr_, ind = 0, xs_ = 1, ys_ = 1, rot_ = 0, clr_ = c_white, alp_ = 1) {
	if ( !sprite_exists(spr_) ) { exit; }
	var w = sprite_get_width(spr_) * xs_ + ( rot_ mod 90 ), h = sprite_get_height(spr_) * ys_ + ( rot_ mod 90 ), buff = buffer_create(w * h * 4, buffer_fixed, 1);
	var temp = surface_create(w, h);
	
	surface_set_target(temp);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	shader_set(shd_bgr);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(spr_, ind, ( rot_ == 0 ? sprite_get_xoffset(spr_) : ( w/ 2 ) ), ( rot_ == 0 ? sprite_get_yoffset(spr_) : ( h/ 2 ) ), xs_, ys_, rot_, clr_, alp_);
	gpu_set_blendmode(bm_normal); gpu_set_blendequation(bm_eq_add);
	surface_reset_target();
	shader_reset();
	
	buffer_get_surface(buff, temp, 0);
	clipboard_set_bitmap(buffer_get_address(buff), w, h);
	buffer_delete(buff); surface_free(temp);
}