///@desc 
if ( !global.pref.soupyicon ) { exit; }
if ( !surface_exists(surf) ) { surf = surface_create(w, h); exit; }
if ( !surface_exists(surf2) ) { surf2 = surface_create(w2, h2); exit; }
image_blend = global.pref.randomclr ? make_color_hsv(current_time/ 50 mod 255, 200, 255) : global.pref.themeclr;