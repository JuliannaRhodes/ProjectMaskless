// on step

// player state
state();
if (room == rm_main) {
    state = player_state_free;
}
if (room == rm_battle) {
    state = player_state_menus;
}

// get keyboard input
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_int1_press = keyboard_check_pressed(vk_enter);
key_int1_hold  = keyboard_check(vk_enter);


// chatterbox

if (key_int1_press==1)  {
	
	if (ChatterboxIsStopped(chatterbox)) {	
		var check_x = lengthdir_x(32, animdir * 90) + x;
		var check_y = lengthdir_y(32, animdir * 90) + y;
		var who_is_here = instance_place(check_x, check_y, obj_npc2);
		if (who_is_here != noone) {	
			ChatterboxJump(chatterbox, who_is_here.node_name);
			currently_talking = who_is_here;
		}
	} else if (ChatterboxIsWaiting(chatterbox)) {
		ChatterboxContinue(chatterbox);
	}
	
	if (not ChatterboxIsStopped(chatterbox)) {
		current_text = ChatterboxGetContent(chatterbox, 0);
		current_text_index = 0;
	} else {
		current_text = "";
		currently_talking = noone;
	}
}

// --- Check if player walked too far away ---
if (currently_talking != noone) {
    var dist = point_distance(x, y, currently_talking.x, currently_talking.y);
    
    if (dist > 96) { // adjust this number to your liking (96px = about 3 tiles)
        ChatterboxStop(chatterbox); // end dialogue safely
        current_text = "";
        currently_talking = noone;
    }
}


// end step