if (currently_talking != noone && current_text != "") {
    // --- GUI dimensions ---
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // --- Option info ---
    var _count = ChatterboxGetOptionCount(chatterbox);
    var options_width = 0;
    var options_height = 0;
    
    if (_count > 0 && !ChatterboxIsWaiting(chatterbox)) {
        var _max_w = 0;
        var _max_h = string_height("A"); // base height per option
        for (var i = 0; i < _count; i++) {
            if (!ChatterboxGetOptionConditionBool(chatterbox, i)) continue;
            _max_w = max(_max_w, string_width(ChatterboxGetOption(chatterbox, i)));
        }
        options_width = _max_w + op_border * 2;
        options_height = op_border * 2 + (_count - 1) * op_space + _max_h;
    }
    
    // --- Dialogue box width ---
    var box_width  = min(gui_w * 0.5, gui_w - options_width - 48); // leave space for options
    var box_height = 140;
    
    var right_padding = 32;
    var x1 = gui_w - box_width - options_width - right_padding; // shift left if options exist
    var y1 = gui_h - box_height - 40;

    // --- Draw dialogue background ---
    draw_sprite_stretched(spr_guibg_black, 0, x1, y1, box_width, box_height);

    // --- Draw dialogue text ---
    var text_x = x1 + 16;
    var text_y = y1 + 28;
    var text_width = box_width - 32;

    draw_set_color(c_white);
    draw_set_font(fnt_jerseysmall);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_text_ext(text_x, text_y, string_copy(current_text, 1, current_text_index), -1, text_width);
    current_text_index = min(current_text_index + 1, string_length(current_text));

    // --- Draw options box to the right, horizontally aligned ---
    if (_count > 0 && !ChatterboxIsWaiting(chatterbox)) {
        var ox = x1 + box_width + 8; // small gap to the right of dialogue box
        var oy = y1;                 // align top with dialogue box

        draw_sprite_stretched(spr_guibg_black, 0, ox, oy, options_width, options_height);

        var _x = ox + op_border;
        var _y = oy + op_border;

        for (var i = 0; i < _count; i++) {
            if (!ChatterboxGetOptionConditionBool(chatterbox, i)) continue;

            var _string = ChatterboxGetOption(chatterbox, i);
            var _c = c_white;
            if (option_index == i) {
                _c = c_red;
                _string = "*" + _string;
            }

            draw_text_color(_x, _y + op_space * i, _string, _c, _c, _c, _c, 1);
        }
    }
}
