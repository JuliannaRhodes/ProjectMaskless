// on step

// get keyboard input
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_int1_press = keyboard_check_pressed(vk_space);
key_int1_hold  = keyboard_check(vk_space);


//calculate x and y  values regarding input
move_x = (key_right - key_left) * move_speed;
move_y = (key_down - key_up) * move_speed;

if (move_x <>0) then move_y=0;
if (move_y <>0) then move_x=0; 
	

// set player facing
if (move_x>0)
	{
	image_angle=0;
	}
if (move_x<0)
	{
	image_angle=180; 
	}
if (move_y>0)
	{
	image_angle = 270;
	}
if (move_y<0)
	{
	image_angle=90;
	}

// move player and collide with walls	
move_and_collide( move_x , move_y, obj_inviswall, 4, 0, 0, move_speed, -1);

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