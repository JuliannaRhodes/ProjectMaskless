
    if (keyboard_check_direct(ord("K")) || keyboard_check_direct(ord("k"))) {
        image_index = 5;
    } else {
        image_index = 4;
    }
	
	
    if (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(ord("k"))) {
        global.blue_pressed = true;
    } else {
        global.blue_pressed = false;
    }
	