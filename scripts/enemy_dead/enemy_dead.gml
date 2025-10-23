function enemy_dead(){
	global.return_room = rm_main; // the room you want to go back to
	global.x = 100; // safe X for player
	global.y = 300; // safe Y for player
	room_goto(global.return_room);

}