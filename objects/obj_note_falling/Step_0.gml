if (image_index == 1 and global.green_pressed) is_correct_fret = true
if (image_index == 2 and global.red_pressed) is_correct_fret = true
if (image_index == 3 and global.orange_pressed) is_correct_fret = true
if (image_index == 4 and global.blue_pressed) is_correct_fret = true

x -= global.move_speed

if x > room_width + 25 {
	instance_destroy();
}

if keyboard_check_pressed(vk_space) {
	var x_distance = abs(x - obj_hitbox.x)
	
	if is_correct_fret  and x_distance <=100 {
		
		if x_distance <= 25 {
			global.points += 100
			var nicejob = instance_create_layer(550,200, "Instances", obj_nicejob)
			nicejob.text_to_draw = "PERFECT!"
		}
		else if x_distance <= 50 {
			global.points += 70
			var nicejob = instance_create_layer(550,200, "Instances", obj_nicejob)
			nicejob.text_to_draw = "Nice!"
		}
		else if x_distance <= 75 {
			global.points += 40
			var nicejob = instance_create_layer(550,200, "Instances", obj_nicejob)
			nicejob.text_to_draw = "Okay"
			}
		else {
			global.points += 10
			var nicejob = instance_create_layer(550,200, "Instances", obj_nicejob)
			nicejob.text_to_draw = "Bad"
		}
		
		instance_destroy()
		
	}
}
		


