if (place_meeting(x, y, obj_pc1))
{
    show_debug_message("You won!");
    global.you_won = true;
	audio_play_sound(snd_winvolume, 1, false);
	with (obj_pc1) state = player_state_menus;
}
