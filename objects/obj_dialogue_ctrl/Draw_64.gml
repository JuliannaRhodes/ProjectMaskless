var portrait_sprite = spr_portrait_frame; // default fallback portrait

if (currently_talking != noone && current_text != "") {
    // --- GUI dimensions ---
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    // --- Set font BEFORE measuring text ---
    draw_set_font(fnt_jerseysmall);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // --- Portrait sprite logic ---
    switch (currently_talking.object_index) {
        case obj_npc1: portrait_sprite = spr_portrait_npc1; break;
        case obj_npc2: portrait_sprite = spr_portrait_npc2; break;
        default:       portrait_sprite = spr_portrait_frame; break;
    }

    // --- Layout sizes ---
    var box_width  = gui_w * 0.55;   // slightly wider
    var box_height = 140;
    var min_padding = 24;
    var spacing = 30;

    // --- Option info ---
    var _count = ChatterboxGetOptionCount(chatterbox);
    var options_width = 200; // start with safe minimum
    var options_height = box_height;
    var visible_options = 0;

    if (_count > 0 && !ChatterboxIsWaiting(chatterbox)) {
        var _max_w = 0;
        for (var i = 0; i < _count; i++) {
            if (!ChatterboxGetOptionConditionBool(chatterbox, i)) continue;
            _max_w = max(_max_w, string_width(ChatterboxGetOption(chatterbox, i)));
            visible_options += 1;
        }
        if (_max_w > 0) {
            options_width = _max_w + op_border * 2 + min_padding + 20;
        }
    }

    // --- Portrait info ---
    var frame_w = sprite_get_width(spr_portrait_frame);
    var frame_h = sprite_get_height(spr_portrait_frame);
    var frame_scale = box_height / frame_h;
    var portrait_w = frame_w * frame_scale;
    var portrait_padding = 16;

    // --- Combined width for centering ---
    var total_width = portrait_w + portrait_padding + box_width;
    if (visible_options > 0)
        total_width += options_width + 12;

    // --- Center horizontally ---
    var center_x = (gui_w - total_width) / 2;
    var y_offset = 40; // move everything slightly lower
    var y1 = gui_h - box_height - y_offset;

    // --- Position each element ---
    var portrait_x = center_x;
    var dialogue_x = portrait_x + portrait_w + portrait_padding;
    var options_x  = dialogue_x + box_width + 12;

    // --- Draw portrait ---
    draw_sprite_ext(
        portrait_sprite,
        0,
        portrait_x,
        y1,
        frame_scale,
        frame_scale,
        0,
        c_white,
        1
    );

    // --- Draw dialogue box ---
    draw_sprite_stretched(spr_guibg_black, 0, dialogue_x, y1, box_width, box_height);

    // --- Draw dialogue text ---
    var text_x = dialogue_x + 16;
    var text_y = y1 + 28;
    var text_width = box_width - 32;

    draw_set_color(c_white);
    draw_text_ext(text_x, text_y, string_copy(current_text, 1, current_text_index), -1, text_width);
    current_text_index = min(current_text_index + 1, string_length(current_text));

    // --- Draw options box ---
    if (visible_options > 0 && !ChatterboxIsWaiting(chatterbox)) {
        var oy = y1;
        var ow = max(200, options_width); // ensure minimum width
        var oh = options_height;

        draw_sprite_stretched(spr_guibg_black, 0, options_x, oy, ow, oh);

        var total_options_height = spacing * (visible_options - 1) + string_height("A");
        var _x = options_x + op_border + min_padding / 2;
        var _y = oy + (oh - total_options_height) / 2;

        var drawn_index = 0;
        for (var i = 0; i < _count; i++) {
            if (!ChatterboxGetOptionConditionBool(chatterbox, i)) continue;

            var _string = ChatterboxGetOption(chatterbox, i);
            var _c = (option_index == i) ? c_red : c_white;
            if (option_index == i) _string = "*" + _string;

            draw_text_color(_x, _y + spacing * drawn_index, _string, _c, _c, _c, _c, 1);
            drawn_index += 1;
        }
    }
}
