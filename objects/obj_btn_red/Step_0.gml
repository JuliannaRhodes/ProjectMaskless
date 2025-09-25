if keyboard_check_direct(ord("F")) or keyboard_check_direct(ord("f")) {
	image_index = 5
	global.red_pressed = true
}
else {
	image_index = 2
	global.red_pressed = false
}