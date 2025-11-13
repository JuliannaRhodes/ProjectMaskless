function hurt_player(_damage){

global.player_hp = max(0, global.player_hp-_damage);
	if (global.player_hp > 0)
	{
		if (instance_exists(obj_battle_controller)) {
        with (obj_battle_controller) player_flash_timer = 15; // lasts 15 frames
		}
	}
	else if (!global.player_dead)
	{
		global.player_dead = true;
		with (obj_pc1) state = player_state_dead;
	}
}