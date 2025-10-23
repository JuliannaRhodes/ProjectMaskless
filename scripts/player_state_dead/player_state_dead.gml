function player_state_dead()
{
    if (room != rm_death)
    {
        audio_stop_all();
        room_goto(rm_death);
			if (instance_exists(global.player_instance)) {
	            with(global.player_instance) instance_destroy();
			 }
    }
}
