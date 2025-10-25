if (currently_talking != noone && current_text != "") {
	var x1 = 100
	var y1 = window_get_height()-160;
	var x2 = window_get_width();
	var y2 = window_get_height();
	
	var box_w = x2 - x1;
    var box_h = y2 - y1;
	
	draw_sprite_stretched(spr_guibg_black, 0, x1, y1, box_w, box_h);
	
	
	var text_x = x1 + 32;
	var text_y = y1 + 32;
	
	draw_set_color(c_white);
	draw_set_font(fnt_jerseysmall);
	draw_text_ext(text_x, text_y, string_copy(current_text, 1, current_text_index), -1, window_get_width() - 64);
	current_text_index++;
}