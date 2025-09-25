if keyboard_check_direct(ord("J")) or keyboard_check_direct(ord("j")) {
	image_index = 5
	global.orange_pressed = true
}
else {
	image_index = 3
	global.orange_pressed = false
}