// Store the current alignment before making any changes
var old_halign = draw_get_halign();
var old_valign = draw_get_valign();


if (battle_phase == BattlePhase.MENU) {
    // --- Bottom area dimensions ---
    var bottom_y = window_get_height() - 300;
    var bottom_h = 300;

    // --- Left textbox (instructions) ---
    var left_x = 0;
    var left_w = window_get_width() * 0.87;
    var left_y = bottom_y;
    var left_h = bottom_h;
    draw_sprite_stretched(spr_fight_menu, 0, left_x, left_y, left_w, left_h);

    // --- Instruction text left padding ---
    var text_padding_x = 50; // distance from left edge

       // --- Draw instruction text (left-center aligned) ---
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(left_x + text_padding_x, left_y + left_h / 2,
              "Press D F J and K to hit the notes on time");

    // --- Right textbox (menu options) ---
    var right_w = window_get_width() * 0.10;
    var right_x = window_get_width() - right_w;
    var right_y = bottom_y;
    var right_h = bottom_h;
    draw_sprite_stretched(spr_fight_menu, 0, right_x, right_y, right_w, right_h);

    // --- Draw menu options inside right box ---
    var padding_x = 40;
    var line_height = 50;
    var total_menu_height = array_length(menu_options) * line_height;
    var start_y = right_y + (right_h / 2) - (total_menu_height / 2);

    draw_set_font(fnt_jersey);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    for (var i = 0; i < array_length(menu_options); i++) {
        var option_text = menu_options[i];
        var draw_y = start_y + line_height * i;

        if (i == menu_choice) {
            draw_set_color(c_red);
            draw_text(right_x + padding_x, draw_y, "* " + option_text);
        } else {
            draw_set_color(c_white);
            draw_text(right_x + padding_x, draw_y, option_text);
        }
    }
}


// --- BATTLE PHASE: RHYTHM ---
if (battle_phase == BattlePhase.RHYTHM) {
    draw_set_font(fnt_jerseysmall);
    draw_set_color(c_white);

    // Top-left score / playing / credits
    var top_padding_x = 20;
    var top_padding_y = 10;
    var line_spacing = 40;

    // Use a temporary alignment for this specific section
	draw_set_valign(fa_top);
    draw_set_halign(fa_left);


    draw_text(top_padding_x, top_padding_y + line_spacing, "Playing: ");
    draw_text(top_padding_x, top_padding_y + 2 * line_spacing, credits_to_draw);
}

// --- Bottom area / left box dimensions (always defined) ---
draw_set_font(fnt_jerseysmall);
var bottom_h = 300;
var bottom_y = window_get_height() - bottom_h;

var left_x = 0;
var left_w = window_get_width() * 0.87;
var left_y = bottom_y;
var left_h = bottom_h;

// --- Sprite dimensions ---
var healthbar_width = 350;
var healthbar_height = 64;
var fill_height = 25;
var padding_left = 20;
var padding_right = 20;
var padding_y = (healthbar_height - fill_height) / 2;

// --- Player HP Bar (top-left, above left box) ---
var player_healthbar_x = left_x + 20;
var player_healthbar_y = left_y - healthbar_height - 20; 
var player_hp_ratio = global.player_hp / global.player_max_hp;
var player_fill_width = (healthbar_width - padding_left - padding_right) * player_hp_ratio;

// Draw player HP bar
draw_sprite_stretched(spr_healthbar_bg, 0, player_healthbar_x, player_healthbar_y, healthbar_width, healthbar_height);
draw_sprite_stretched(spr_healthbar_player, 0, player_healthbar_x + padding_left, player_healthbar_y + padding_y, player_fill_width, fill_height);
draw_sprite_stretched(spr_healthbar_border, 0, player_healthbar_x, player_healthbar_y, healthbar_width, healthbar_height);

// Player HP Text
var text_padding_y = 8;
var old_halign = draw_get_halign();
var old_valign = draw_get_valign();

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
var player_hp_text = "Player HP: " + string(global.player_hp) + " / " + string(global.player_max_hp);
draw_text(player_healthbar_x + healthbar_width / 2, player_healthbar_y - text_padding_y, player_hp_text);

// --- Enemy HP Bar (top-right) ---
var npc_healthbar_x = window_get_width() - healthbar_width - 20;
var npc_healthbar_y = 60;
var npc_hp_ratio = global.npc1_hp / global.npc1_max_hp;
var npc_fill_width = (healthbar_width - padding_left - padding_right) * npc_hp_ratio;

// Draw enemy HP bar
draw_sprite_stretched(spr_healthbar_bg, 0, npc_healthbar_x, npc_healthbar_y, healthbar_width, healthbar_height);
draw_sprite_stretched(spr_healthbar_enemy, 0, npc_healthbar_x + padding_left, npc_healthbar_y + padding_y, npc_fill_width, fill_height);
draw_sprite_stretched(spr_healthbar_border, 0, npc_healthbar_x, npc_healthbar_y, healthbar_width, healthbar_height);

// Enemy HP Text
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
var npc_hp_text = "Enemy HP: " + string(global.npc1_hp) + " / " + string(global.npc1_max_hp);
draw_text(npc_healthbar_x + healthbar_width / 2, npc_healthbar_y - text_padding_y, npc_hp_text);

// --- Restore previous alignment ---
draw_set_halign(old_halign);
draw_set_valign(old_valign);