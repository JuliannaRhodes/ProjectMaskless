// Begin rhythm after item use
if (global.item_used_this_turn) {
	global.current_action = "ATTACK"
    battle_phase = BattlePhase.RHYTHM;

    frame_counter = 0;
    note_counter = 0;
    beat_counter = 0;
    frame_beat_counter = frame_beat_counter_total;
    audio_play_sound(snd_song_p1, 1, false);
    rhythm_timer = room_speed * 15;
}
