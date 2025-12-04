if (!active) exit;

draw_set_font(fnt_jerseysmall);

// Dynamically calculate width
var _new_w = 0;
var _count = ChatterboxGetOptionCount(chatterbox);
scribble_anim_wave(1,20,.2)

for (var i = 0; i < _count; i++) {
    var _option = ChatterboxGetOption(obj_pc1.chatterbox, i);
    var _op_w = string_width(_option);
    _new_w = max(_new_w, _op_w);
}

width  = _new_w + op_border * 2;
height = op_border * 2 + string_height(ChatterboxGetOption(obj_pc1.chatterbox, 0)) + (_count - 1) * op_space;

// Right-align
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var x1 = gui_w - width - 32;  // 32px margin from right
var y1 = gui_h - height - 40; // 40px above bottom

// Draw box background
draw_sprite_stretched(spr_guibg_black, 0, x1, y1, width, height);

// Set starting position inside the box
var _x = x1 + op_border;
var _y = y1 + op_border;

// Draw each option
draw_set_valign(fa_top);
draw_set_halign(fa_left);

for (var i = 0; i < _count; i++) {
    // Skip options that fail their condition
    if (!ChatterboxGetOptionConditionBool(obj_pc1.chatterbox, i)) continue;

    var _string = ChatterboxGetOption(obj_pc1.chatterbox, i);
    var _c = c_white;

    // Highlight selected option
    if (option_index == i) {
        _c = c_red;
        _string = "*" + _string;
    }

    draw_text_color(_x, _y + op_space * i, _string, _c, _c, _c, _c, 1);
}

