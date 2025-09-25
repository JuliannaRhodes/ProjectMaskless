if (battle_phase ==BattlePhase.MENU) {
}

if (battle_phase == BattlePhase.RHYTHM) {

    draw_set_font(fnt_jersey);
    draw_set_color(c_white);
    draw_text(550, 100, score_to_draw);
    draw_text(550, 200, "Playing: ");
    draw_text(100, 300, credits_to_draw);
}
