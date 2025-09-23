if keyboard_check_direct(ord("D")) or keyboard_check_direct(ord("d")) {
	image_index = 5
	global.blue_pressed = true
}
else {
	image_index = 4
	global.blue_pressed = false
}