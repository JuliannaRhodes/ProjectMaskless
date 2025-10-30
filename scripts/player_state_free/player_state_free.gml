function player_state_free() {
    // --- Movement input ---
    move_x = (key_right - key_left) * move_speed;
    move_y = (key_down - key_up) * move_speed;

    // Prevent diagonal movement
    if (move_x != 0) move_y = 0;
    if (move_y != 0) move_x = 0;

    // --- Determine facing direction ---
    if (move_x != 0 || move_y != 0) {
        if (abs(move_x) > abs(move_y)) {
            if (move_x > 0) animdir = 2;  // right
            else animdir = 1;             // left
        } else {
            if (move_y > 0) animdir = 0;  // down
            else animdir = 3;             // up
        }
    }

    // --- Initialize persistent variables ---
    if (!variable_instance_exists(id, "frame_timer")) frame_timer = 0;
    if (!variable_instance_exists(id, "frame_index")) frame_index = 0;
    var frame_delay = 8; // number of steps before switching frame (increase for slower)

    // --- Animation handling ---
    frame_timer += 1;
    switch (animdir) {
        case 0: // down
            if (move_y > 0) {
                if (frame_timer >= frame_delay) {
                    frame_index = (frame_index + 1) mod 2; // 2-frame walk
                    frame_timer = 0;
                }
                image_index = 1 + frame_index;
            } else {
                image_index = 0;
                frame_index = 0;
                frame_timer = 0;
            }
            break;

        case 1: // left
            if (move_x < 0) {
                if (frame_timer >= frame_delay) {
                    frame_index = (frame_index + 1) mod 3; // idle-step-idle
                    frame_timer = 0;
                }
                switch (frame_index) {
                    case 0: image_index = 3; break; // idle
                    case 1: image_index = 4; break; // step
                    case 2: image_index = 3; break; // idle
                }
            } else {
                image_index = 3;
                frame_index = 0;
                frame_timer = 0;
            }
            break;

        case 2: // right
            if (move_x > 0) {
                if (frame_timer >= frame_delay) {
                    frame_index = (frame_index + 1) mod 3; // idle-step-idle
                    frame_timer = 0;
                }
                switch (frame_index) {
                    case 0: image_index = 6; break; // idle
                    case 1: image_index = 7; break; // step
                    case 2: image_index = 6; break; // idle
                }
            } else {
                image_index = 6;
                frame_index = 0;
                frame_timer = 0;
            }
            break;

        case 3: // up
            if (move_y < 0) {
                if (frame_timer >= frame_delay) {
                    frame_index = (frame_index + 1) mod 2; // 2-frame walk
                    frame_timer = 0;
                }
                image_index = 10 + frame_index;
            } else {
                image_index = 9;
                frame_index = 0;
                frame_timer = 0;
            }
            break;
    }

    // --- Reset scale ---
    image_xscale = 1;
    image_yscale = 1;

    // --- Move player ---
    move_and_collide(move_x, move_y, obj_inviswall, 4, 0, 0, move_speed, -1);
}
