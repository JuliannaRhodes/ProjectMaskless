state = player_state_free;

// on create

key_left = 0;
key_right = 0;
key_up =0;
key_down =0;

key_int1_press = 0;
key_int1_hold = 0;

move_speed = 4;

move_x = 0;
move_y = 0;

global.player_hp = 200;
global.player_max_hp = 200;

hp = global.player_hp;
max_hp = global.player_max_hp;
flash = 0;

global.spawn_x = obj_pc1.x;
global.spawn_y = obj_pc1.y;
starting_x = 190;
starting_y = 300;


// end create