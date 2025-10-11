if (global.player_hp <= 0) {
    // Optional: play a sound, animation, or fade-out first
	room_restart();
    game_restart();
	audio_stop_all();
	room_goto(rm_death);// restarts the current room (full reset)
}