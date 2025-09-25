// battle states
enum BattlePhase {
    MENU,
    ATTACK,
    DEFEND,
    RHYTHM,
    RESOLVE
}

// Start in menu (player chooses Attack/Defend/etc.)
battle_phase = BattlePhase.MENU;
menu_choice = 0; // current menu index
menu_options = ["Attack", "Defend", "Item", "Run"];

// get the background layer ID
bg_layer_id = layer_background_get_id("background_battle");

// start with menu background
layer_background_sprite(bg_layer_id, spr_bg_battlemenu);



global.battle_phase = BattlePhase.MENU;


global.move_speed = 15

global.green_pressed = false
global.red_pressed = false
global.orange_pressed = false
global.blue_pressed = false

global.level = 0
global.points = 0

frame_counter = 0
note_counter = 0

frame_beat_counter = 15
frame_beat_counter_total = 15

beat_counter = 0

function pad_score(value, length) {
	while(string_length(string(value)) < length) {
		value = "0" + string(value)
	}
	
	return value
}

credits_to_draw = "1.mp3 by Leke"
score_to_draw =""

	