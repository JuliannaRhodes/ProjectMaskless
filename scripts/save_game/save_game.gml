function save_game(){
	
	var buffer = buffer_create(1024, buffer_grow, 1);
	
	buffer_write(buffer, buffer_f32, obj_pc1.x);
	buffer_write(buffer, buffer_f32, obj_pc1.y);
	buffer_write(buffer, buffer_u16, global.player_hp);
	buffer_write(buffer, buffer_string, room_get_name(room));
	buffer_write(buffer, buffer_u16, global.npc1_hp);
	
	
	buffer_save(buffer, "savefile.dat");
	buffer_delete(buffer);
	show_message("You have saved the game!")
}