if (currently_talking != noone && current_text != "") {
    // Get GUI dimensions
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    // --- Box dimensions ---
    var box_width  = gui_w * 0.75;  // thinner box (75% of total width)
    var box_height = 140;           // you can tweak this to make it taller/thinner

    // Center horizontally and stick near bottom
    var x1 = (gui_w - box_width) / 2;
    var y1 = gui_h - box_height - 40; // 40px above bottom edge

    // --- Draw background sprite ---
    draw_sprite_stretched(spr_guibg_black, 0, x1, y1, box_width, box_height);

    // --- Text setup ---
    var text_x = x1 + 32;
    var text_y = y1 + 28;
    var text_width = box_width - 64; // padding from both sides

    draw_set_color(c_white);
    draw_set_font(fnt_jerseysmall);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // --- Draw the text ---
    draw_text_ext(text_x, text_y, string_copy(current_text, 1, current_text_index), -1, text_width);

    // Optional: advance the text index if you're doing typewriter effect
    current_text_index++;
}
