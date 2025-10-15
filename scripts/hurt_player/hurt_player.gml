function hurt_player(_damage){

global.player_hp = max(0, global.player_hp-_damage);
	if (global.player_hp > 0)
	{
		show_debug_message("ouch!");
	}
	else 
	{
		with (obj_pc1) state = player_state_dead()
	}
}