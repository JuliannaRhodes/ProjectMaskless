function player_state_dead()
{
	audio_stop_all();
	room_goto(rm_death)
	global.target_x = -100;
	global.target_y  = -100;

}