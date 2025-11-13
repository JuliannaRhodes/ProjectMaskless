// on step


// get keyboard input
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_int1_press = keyboard_check_pressed(vk_enter);
key_int1_hold  = keyboard_check(vk_enter);

// player state
state();
if (global.entering_battle == true) {
	state = player_state_menus;
}
else if (room == rm_main) {
    state = player_state_free;
}
else if (room == rm_battle) {
    state = player_state_menus;
}



// end step