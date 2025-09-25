
    if (keyboard_check_direct(ord("K")) || keyboard_check_direct(ord("k"))) {
        image_index = 5;
        global.blue_pressed = true;
    } else {
        image_index = 4;
        global.blue_pressed = false;
    }