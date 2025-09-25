if keyboard_check_direct(ord("D")) or keyboard_check_direct(ord("d")) {
	image_index = 5
	global.green_pressed = true
}
else {
	image_index = 1 
	global.green_pressed = false
}