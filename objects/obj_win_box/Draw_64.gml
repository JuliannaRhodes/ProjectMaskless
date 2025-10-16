if (global.you_won) == true
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_times)
	draw_set_color(c_white)
    draw_text(screen_center_x, screen_center_y, "YOU WON!");
}
