if keyboard_check_direct(ord("F")) or keyboard_check_direct(ord("f")) {
	image_index = 5
}
else {
	image_index = 2
}
if keyboard_check_pressed(ord("F")) or keyboard_check_pressed(ord("f")) {
	global.red_pressed = true
}
else {
	global.red_pressed = false
}