if (currently_talking != noone && current_text != "") {
    // GUI dimensions
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    // Box dimensions
    var box_width  = gui_w * 0.5;  // less wide (50% of screen)
    var box_height = 140;

    // Right-align: x position = right edge - box width - padding
    var right_padding = 32;
    var x1 = gui_w - box_width - right_padding;
    var y1 = gui_h - box_height - 40; // still near bottom

    // Draw background
    draw_sprite_stretched(spr_guibg_black, 0, x1, y1, box_width, box_height);

    // Text setup
    var text_x = x1 + 16;  // small padding inside box
    var text_y = y1 + 28;
    var text_width = box_width - 32;

    draw_set_color(c_white);
    draw_set_font(fnt_jerseysmall);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // Draw dialogue text
    draw_text_ext(text_x, text_y, string_copy(current_text, 1, current_text_index), -1, text_width);

    current_text_index++;

if (!ChatterboxIsStopped(chatterbox) && !ChatterboxIsWaiting(chatterbox)) {
    
    // Create or get dialogue menu
    var menu_inst = instance_find(obj_dialoguemenu, 0);
    if (!menu_inst) menu_inst = instance_create_layer(0,0,"GUI", obj_dialoguemenu);
    
    menu_inst.active = true;
    menu_inst.pos = 0;
    
    // Populate options
    menu_inst.op_length = ChatterboxGetOptionCount(chatterbox);
    menu_inst.option = array_create(menu_inst.op_length);
    for (var i = 0; i < menu_inst.op_length; i++) {
        // Only show options where condition passes
        if (ChatterboxGetOptionConditionBool(chatterbox, i)) {
            menu_inst.option[i] = ChatterboxGetOption(chatterbox, i);
        } else {
            menu_inst.option[i] = "[Unavailable]";
        }
    }
}

}