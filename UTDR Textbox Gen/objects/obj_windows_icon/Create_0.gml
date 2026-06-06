///@desc 
surf = -1;
ico = spr_soul_icon;
w = sprite_get_width(ico); h = sprite_get_height(ico); x = sprite_get_xoffset(ico); y = sprite_get_yoffset(ico);

surf2 = -1;
ico2 = spr_soul_soup;
w2 = sprite_get_width(ico2); h2 = sprite_get_height(ico2); x2 = sprite_get_xoffset(ico2); y2 = sprite_get_yoffset(ico2);

var rdm = choose(
	"So soupy!!", "Make sure to eat some soup today!", "Soupy loves you :)", "What's your favorite soup btw?",
	"Share your creations with #soupgen! I WILL see it!", "What are we generating today, boys?", "dude i love soup",
	"National Soup Day when?", "Soup heals all.", "Soupy the Soupy", "Soupy Boopy", "good soup", "Check out True Geno!",
	"i am god", "Filled with Determination", "Filled with good soup", "Good soup coming right up!", "Good soup is on your way!",
	"You are filled with the power of great soup.", "* Big boner down the lane", "Ultimate bepis", "soup", "ahhh so soupy~"
);
window_set_caption($"UTDR SoupGen | {rdm}");