function spawn_player(x, y){
	var _player = instance_create_layer(x, y, "Instances", obj_pc1);
	_player.state = player_state_free;
	global.player_instance = _player; // store reference
	global.player_hp = global.player_max_hp;
}