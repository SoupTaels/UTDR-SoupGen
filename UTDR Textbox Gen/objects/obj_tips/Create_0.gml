///@desc 
image_speed = 0;
image_index = 3;
hover = false;
TweenEasyFade(0, 1, 0, 30, EaseLinear);
TweenEasyMove(x, y, x, 16, 0, 30, EaseOutBack);
sfx_play(snd_sparkle);

soupyclipm_init();

txt = choose(
	"Did you know that you can add an outline to your text?|Just change the [slant]outline color[/] in the [c_yellow]Style tab![/]|Right-click the colored rectangle to [slant]remove[/] outline.",
	"Want to fit more lines of text in your dialogue?|You can [c_cyan]edit the Line Spacing[/] value in the [c_yellow]Style tab![/]",
	"You can change the asterisk character by changing|the [c_cyan]Asterisk Chr[/] parameter in the [c_yellow]Style tab![/]",
	"You can add an end dialogue indicator to your dialogue!|Find that setting in the [c_yellow]Style tab![/]",
	"You can add a nametag to your dialogue!|Find that setting in the [c_yellow]Portrait tab![/]",
	"Did you know that SoupGen can export your dialogue to a|resolution of [c_cyan]640x480[/]?|Tick on [c_lime]Bigger Resolution[/] in the [c_yellow]Extras tab![/]|With this setting enabled, any reference image you add will show on export!",
	"You can change the UI color to your liking by tinkering with the [slant]UI Color[/] setting in the [c_yellow]Extras tab![/].",
	"SoupGen's icon, on Windows, [rainbow]changes dynamically[/] based|on your theme color, or if [slant]Random Theme[/] is enabled, the icon will|[rainbow][wave]cycle through the colors of the rainbow![/]|But in case you don't want that, turn off [c_yellow]Dynamic Icon[/].|These settings can be found in the [c_yellow]Extras tab![/]",
	"You can change the font the textbox editor uses by changing|the Editor Font parameter in the [c_yellow]Extras tab.[/]",
	"Do you edit dialogue style for a particular character a lot?|Well don't forget you can [c_y]save those settings[/] using [c_lime]Config Presets![/]|Find that setting in the [c_yellow]Extras tab![/]",
	"You can make your own commands using [c_y]Text Macros![/]|Find that setting in the [c_yellow]Extras tab![/]",
	"[c_gold][wheel]I'm so soupy!!",
	"On Windows, you can drag & drop an image or zip file|directly onto the program!",
	"Before asking any questions, please check out the guide!|There's examples for everything that SoupGen offers.",
	"You should go through every setting at least once.|You will find that SoupGen is quite powerful and customizable|if you give it a chance!",
);