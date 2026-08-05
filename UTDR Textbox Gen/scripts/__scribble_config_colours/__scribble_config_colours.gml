// Feather disable all
/// Creates a collection of colour names that map to 24-bit BGR colours
/// Use scribble_rgb_to_bgr() to convert from industry standard RGB colour codes to GM's native BGR format
/// 
/// To add or change colours at runtime, use scribble_color_set()
/// 
/// N.B. That this function is executed on boot. You should never execute this function yourself!

function __scribble_config_colours() {
	static _colours = {
		//Duplicate GM's native colour constants
		c_aqua:    c_aqua, c_a: c_aqua, //alias shortname
		c_black:   c_black, c_bl: c_black,
		c_blue:    c_blue, c_b: c_blue, 
		c_dkgray:  c_dkgray, c_dkg: c_dkgray,
		c_dkgrey:  c_dkgrey,
		c_pink: #fb8f94, c_p: #fb8f94,
		c_gray:    c_gray, c_gr: c_gray,
		c_green:   c_green, c_g: c_green,
		c_grey:    c_grey,
		c_lime:    c_lime, c_l: c_lime,
		c_ltgray:  c_ltgray, c_ltg: c_ltgray, 
		c_ltgrey:  c_ltgrey,
		c_maroon:  c_maroon, c_m: c_maroon,
		c_navy:    c_navy, c_n: c_navy,
		c_olive:   c_olive, c_ol: c_olive,
		c_orange:  c_orange, c_o: c_orange,
		c_purple:  c_purple, c_p: c_purple,
		c_red:     c_red, c_r: c_red,
		c_silver:  c_silver, c_s: c_silver,
		c_teal:    c_teal, c_t: c_teal,
		c_white:   c_white, c_w: c_white,
		c_yellow:  c_yellow, c_y: c_yellow,
    
		//Here are some example colours
		c_coquelicot: scribble_rgb_to_bgr(0xff3800), c_co: scribble_rgb_to_bgr(0xff3800),
		c_smaragdine: scribble_rgb_to_bgr(0x50c875), c_sm: scribble_rgb_to_bgr(0x50c875), 
		c_xanadu:     scribble_rgb_to_bgr(0x738678), c_x:     scribble_rgb_to_bgr(0x738678),
		c_amaranth:   scribble_rgb_to_bgr(0xe52b50), c_am:   scribble_rgb_to_bgr(0xe52b50),
		
		"c_cyan": c_cyan, c_c: c_cyan, //Undertale's cyan color
		"c_gold": c_gold, c_go: c_gold,
	};

	return _colours;
}