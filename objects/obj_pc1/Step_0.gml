script_execute(state);
// on step

if (room == rm_battle) exit; // skip logic while in battle

// get keyboard input
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_int1_press = keyboard_check_pressed(vk_space);
key_int1_hold  = keyboard_check(vk_space);





//if (key_int1_press==1)  {
	
//	if (ChatterboxIsStopped(chatterbox)) {
		
//		if (who_is_here != noone) {
//			ChatterboxJump(chatterbox, who_is_here.node_name);
//			currently_talking = who_is_here;
//		}
//	} else if (ChatterboxIsWaiting(chatterbox)) {
//		ChatterboxContinue(chatterbox);
//	}
	
//	if (not ChatterboxIsStopped(chatterbox)) {
//		current_text = ChatterboxGetContent(chatterbox, 0);
//		current_text_index = 0;
//	} else {
//		current_text = "";
//		currently_talking = noone;
//	}


// end step