function player_state_free(){
	
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

}
