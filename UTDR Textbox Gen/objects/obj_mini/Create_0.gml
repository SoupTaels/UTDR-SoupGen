///@desc 
/*page = -1; //Page to be visible at
face = -1; //Face sprite
index = 0; //Face image index
spd = 0; //Face image speed
alpha = 1; //Face alpha
text = "Test text"; //Text
font = fnt_determination; //Font
*/

scrib = scribble(text);
scrib.build(true);
xoff = 0;
drag = false;
active = false;
once = false;
near = false;
destroying = false;
doublec = false;

draw = method(self, function() {
	if ( SYSTEMUI.dial_text_page != page || SYSTEMUI.ui_paused || SYSTEMUI.ui_tab > 0 || !SYSTEMUI.bord_visible ) { exit; }
	var shake = destroying ? random_range(2, -2) : 0;
	draw_sprite_ensure(face, index, round(x + xoff) + shake, round(y) + shake, 1, 1, 0, destroying ? c_red : c_white, alpha);
	var xx = x + ( sprite_get_width(face)/ 2 ) + 10, yy = y - ( sprite_get_height(face)/ 2 );
	scrib.blend(destroying ? c_red : c_white, alpha).starting_format(font).draw(round(xx + xoff) - shake, round(yy) - shake);
});