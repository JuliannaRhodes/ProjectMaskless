if keyboard_check_direct(ord("D")) or keyboard_check_direct(ord("d")) {
	image_index = 5
}
else {
	image_index = 1 
}
if keyboard_check_pressed(ord("D")) or keyboard_check_pressed(ord("d")) {
	global.green_pressed = true
}
else {
	global.green_pressed = false
}