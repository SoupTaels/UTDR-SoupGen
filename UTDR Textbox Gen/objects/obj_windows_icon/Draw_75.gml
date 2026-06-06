///@desc 
if ( !surface_exists(surf) ) { exit; }
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_sprite_ensure(ico, , , , , , , image_blend);
surface_reset_target();
window_set_icon_surface(surf, false);

if ( !surface_exists(surf2) ) { exit; }
surface_set_target(surf2);
draw_clear_alpha(c_black, 0);
draw_sprite_ensure(ico2, , x2, y2, , , , image_blend);
surface_reset_target();
window_set_icon_surface(surf2, true);