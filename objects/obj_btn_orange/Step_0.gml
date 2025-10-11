if keyboard_check_direct(ord("J")) or keyboard_check_direct(ord("j")) {
	image_index = 5
}
else {
	image_index = 3
}
if keyboard_check_pressed(ord("J")) or keyboard_check_pressed(ord("j")) {
	global.orange_pressed = true
}
else {
	global.orange_pressed = false
}