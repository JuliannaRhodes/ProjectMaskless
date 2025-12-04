draw_set_font(fnt_menu);

// dynamically get width and height of menu
var _new_w = 0;
for(var i = 0; i < op_length; i++)
	{
var _op_w = string_width(option[menu_level, i]);
_new_w = max(_new_w, _op_w);
	}
	
width = _new_w + op_border*2;
height = op_border*2 + string_height(option[0,0]) + (op_length-1)*op_space;

// center menu
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - width/2;
y = camera_get_view_x(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - height/2;

// draw menu background

draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

// draw the options
draw_set_valign(fa_top);
draw_set_halign(fa_left);

// Animate the wave once per frame
scribble_anim_wave(1, 20, 0.2);

for (var i = 0; i < op_length; i++) {
    var scribble_string;

    // Selected option
    if (pos == i) {
        // Bold + red star (no wobble)
        var star_text = "[#ff0000][b]* [/b]";

        // Bold + red + wobble for the option text only
        var main_text = "[#ff0000][b][wave]" + option[menu_level, i] + "[/wave][/b]";

        scribble_string = star_text + main_text;

    } else {
        // Non-selected option
        scribble_string = option[menu_level, i];
    }

    // Draw the Scribble text
    draw_text_scribble(x + op_border, y + op_border + op_space * i, scribble_string);
}