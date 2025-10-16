function player_state_dead()
{
	audio_stop_all();
	room_goto(rm_death)

}