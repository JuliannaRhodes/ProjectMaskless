var portrait_sprite = spr_portrait_frame; // default fallback portrait

// Only draw if NPC exists and text is active
if (currently_talking != noone && instance_exists(currently_talking) && current_text != "") {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    // --- Portrait sprite selection safely ---
    switch (currently_talking.object_index) {
        case obj_npc1: portrait_sprite = spr_portrait_npc1; break;
        case obj_npc2: portrait_sprite = spr_portrait_npc2; break;
    }

    // --- Dialogue box sizing ---
    var box_width  = gui_w * 0.55;
    var box_height = 140;
    var portrait_padding = 16;
    var options_padding = 12;

    var portrait_w = sprite_get_width(portrait_sprite);
    var portrait_h = sprite_get_height(portrait_sprite);

    var ow = 160; // options box width
    var oh = box_height;

    var total_width = portrait_w + portrait_padding + box_width + options_padding + ow;
    var center_x = (gui_w - total_width) / 2;
    var y1 = gui_h - box_height - 40;

    var portrait_x = center_x;
    var dialogue_x = portrait_x + portrait_w + portrait_padding;
    var options_x  = dialogue_x + box_width + options_padding;

    // Draw portrait
    draw_sprite(portrait_sprite, 0, portrait_x, y1 + (box_height - portrait_h) / 2);

    // Draw dialogue background
    draw_sprite_stretched(spr_guibg_black, 0, dialogue_x, y1, box_width, box_height);

    // Draw Scribble text
    draw_set_font(fnt_jersey);
    draw_set_color(c_white);

    var text_padding_x = 40;
    var text_padding_y = 40;

    if (active) {
        scribble(current_text)
            .starting_format("fnt_jersey", c_white)
            .draw(dialogue_x + text_padding_x, y1 + text_padding_y, typist);
    }

    // Draw options safely
    var _count = ChatterboxGetOptionCount(chatterbox);
    if (_count > 0 && !ChatterboxIsWaiting(chatterbox)) {

        var visible_options = 0;
        var max_text_width = 0;

        // Measure widest visible option
        for (var i = 0; i < _count; i++) {
            if (!ChatterboxGetOptionConditionBool(chatterbox, i)) continue;
            var w = string_width_scribble(ChatterboxGetOption(chatterbox, i));
            max_text_width = max(max_text_width, w);
            visible_options++;
        }

        var padding = 24;
        var min_width = 180;
        var max_width = 260;
        ow = clamp(max_text_width + padding, min_width, max_width);

        draw_sprite_stretched(spr_guibg_black, 0, options_x, y1, ow, oh);

        var total_options_height = 30 * (visible_options - 1) + string_height("A");
        var _x = options_x + padding / 2 + 20;
        var _y = y1 + (oh - total_options_height) / 2;

        draw_set_font(fnt_jerseysmall);
        var drawn_index = 0;
        for (var i = 0; i < _count; i++) {
            if (!ChatterboxGetOptionConditionBool(chatterbox, i)) continue;

            var _string = ChatterboxGetOption(chatterbox, i);
            var _c = (option_index == i) ? c_red : c_white;
            if (option_index == i) _string = "*" + _string;

            draw_text_color(_x, _y + 30 * drawn_index, _string, _c, _c, _c, _c, 1);
            drawn_index++;
        }
    }
}