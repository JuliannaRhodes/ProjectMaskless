if (battle_phase == BattlePhase.MENU) {
    // --- Bottom area dimensions ---
    var bottom_y = window_get_height() - 200;
    var bottom_h = 220;
    
    // --- Left textbox (instructions) ---
    var left_x = 0;
    var left_w = window_get_width() * 0.80; // 65% of screen width
    var left_y = bottom_y;
    var left_h = bottom_h;

    draw_sprite_stretched(spr_fight_menu, 0, left_x, left_y, left_w, left_h);

    var padding_x = 32;
    var padding_y = 32;

    draw_set_color(c_white);
    draw_text(left_x + padding_x, left_y + padding_y, "Press D F J and K to hit the notes on time");

    // --- Right textbox (menu options) ---
    var right_w = window_get_width() * 0.15; // remaining 35% of screen width
    var right_x = window_get_width() - right_w;
    var right_y = bottom_y;
    var right_h = bottom_h;

    draw_sprite_stretched(spr_fight_menu, 0, right_x, right_y, right_w, right_h);

    // Draw menu options inside right box
    var line_height = 50;

    for (var i = 0; i < array_length(menu_options); i++) {
        var option_text = menu_options[i];
        var draw_y = right_y + padding_y + line_height * i;

        // Right-align text inside right box
        if (i == menu_choice) {
            draw_set_color(c_red);
            draw_text(right_x + right_w - padding_x - string_width("* " + option_text), draw_y, "* " + option_text);
        } else {
            draw_set_color(c_white);
            draw_text(right_x + right_w - padding_x - string_width(option_text), draw_y, option_text);
        }
    }
}




if (battle_phase == BattlePhase.RHYTHM) {

    draw_set_font(fnt_jersey);
    draw_set_color(c_white);
    draw_text(550, 100, score_to_draw);
    draw_text(550, 200, "Playing: ");
    draw_text(100, 300, credits_to_draw);
}

// --- Draw HP ---
draw_set_color(c_red);
draw_text(50, 50, "Player HP: " + string(global.player_hp) + " / " + string(global.player_max_hp));

draw_set_color(c_green);
draw_text(400, 50, "Enemy HP: " + string(global.npc1_hp) + " / " + string(global.npc1_max_hp));



//var x1 = 100
//	var y1 = window_get_height()-160;
//	var x2 = window_get_width();
//	var y2 = window_get_height();
//	
//	var box_w = x2 - x1;
//    var box_h = y2 - y1;
	
//	draw_sprite_stretched(spr_guibg_black, 0, x1, y1, box_w, box_h);