if (battle_phase ==BattlePhase.MENU) {
	var menu_x = 1050;   // x-position on the right side
    var menu_y = 550;   // top position
    var line_height = 50;

    for (var i = 0; i < array_length(menu_options); i++) {
        var option_text = menu_options[i];
        var draw_y = menu_y + i * line_height;

        // highlight current choice
        if (i == menu_choice) {
            draw_set_color(c_red);
            draw_text(menu_x - 20, draw_y, "* " + option_text);
        } else {
            draw_set_color(c_white);
            draw_text(menu_x, draw_y, option_text);
        }
    }
	draw_text(118,600, "Press D F J and K to hit the notes on time");
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

