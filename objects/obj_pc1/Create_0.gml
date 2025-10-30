// movements

key_left = 0;
key_right = 0;
key_up =0;
key_down =0;
image_xscale = 1;
image_yscalse = 1;

key_int1_press = 0;
key_int1_hold = 0;

move_speed = 2.3;

move_x = 0;
move_y = 0;
animdir = 0; // Default direction, e.g. facing up or right depending on your setup

// variables

state = player_state_menus;

global.player_instance = id; // store the player's own id

global.player_hp = 200;
global.player_max_hp = 200;
hp = global.player_hp;
max_hp = global.player_max_hp;
global.player_dead = false;


flash = 0;

x = global.x;
y = global.y;
global.x = global.starting_x;
global.y = global.starting_y;
global.starting_x = 192;
global.starting_y = 352;


//chatterbox 
current_text = "";
currently_talking = noone;
current_text_index = 0;
current_text_line_number = 0;

ChatterboxLoadFromFile("TestDialogue.yarn");

chatterbox = ChatterboxCreate("TestDialogue.yarn");

// end create