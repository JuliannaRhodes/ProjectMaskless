function player_state_free() {
    // calculate x and y values regarding input
    move_x = (key_right - key_left) * move_speed;
    move_y = (key_down - key_up) * move_speed;

    if (move_x != 0) move_y = 0;
    if (move_y != 0) move_x = 0; 

// --- Set player facing direction ---
if (move_x != 0 || move_y != 0) {
    if (abs(move_x) > abs(move_y)) {
        if (move_x > 0) animdir = 2;  // right
        else animdir = 1;              // left
    } else {
        if (move_y > 0) animdir = 0;  // down
        else animdir = 3;              // up
    }
}

image_index = animdir;

    // optional: set image angle or flipping
    image_xscale = 1;
    image_yscale = 1; // (you had a typo here: `image_yscalse`)

    // move player and collide with walls    
    move_and_collide(move_x, move_y, obj_inviswall, 4, 0, 0, move_speed, -1);
}
