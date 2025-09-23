if keyboard_check_direct(ord("W")) or keyboard_check_direct(ord("w")) {
	image_index = 5
	global.green_pressed = true
}
else {
	image_index = 1 
	global.green_pressed = false
}