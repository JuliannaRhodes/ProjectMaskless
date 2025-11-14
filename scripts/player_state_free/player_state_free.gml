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
            animdir = (move_x > 0) ? 2 : 1;  // right : left
        } else {
            animdir = (move_y > 0) ? 0 : 3;  // down : up
        }
    }

    // --- Initialize persistent variables ---
    if (!variable_instance_exists(id, "frame_timer")) frame_timer = 0;
    if (!variable_instance_exists(id, "frame_index")) frame_index = 0;
    if (!variable_instance_exists(id, "frame_forward")) frame_forward = true;

    // --- Frame delays ---
    var frame_delay_lr = 20;
    var frame_delay_ud = 20; // up/down slowed to match left/right

    // --- Animation handling ---
    frame_timer++;

    switch (animdir)
    {
        // ================================
        // DOWN (idle 0, walk frames 1,2)
        // ================================
        case 0: // down
    if (move_y > 0) {
        if (frame_timer >= frame_delay_ud) {
            frame_index = (frame_index + 1) mod 4; // 0,1,2,3 cycle
            frame_timer = 0;
        }

        switch (frame_index) {
            case 0: image_index = 1; break; // walk1
            case 1: image_index = 0; break; // idle
            case 2: image_index = 2; break; // walk2
            case 3: image_index = 0; break; // idle
        }
    } else {
        image_index = 0; // idle
        frame_index = 0;
        frame_timer = 0;
    }
break;


        // ================================
        // LEFT (already good)
        // ================================
        case 1:
            if (move_x < 0) {
                if (frame_timer >= frame_delay_lr) {
                    if (frame_forward) frame_index++; else frame_index--;
                    if (frame_index >= 2) { frame_index = 2; frame_forward = false; }
                    if (frame_index <= 0) { frame_index = 0; frame_forward = true; }
                    frame_timer = 0;
                }
                image_index = 4 + frame_index;
            } else {
                image_index = 3;
                frame_index = 0;
                frame_timer = 0;
                frame_forward = true;
            }
        break;

        // ================================
        // RIGHT (already good)
        // ================================
        case 2:
            if (move_x > 0) {
                if (frame_timer >= frame_delay_lr) {
                    if (frame_forward) frame_index++; else frame_index--;
                    if (frame_index >= 2) { frame_index = 2; frame_forward = false; }
                    if (frame_index <= 0) { frame_index = 0; frame_forward = true; }
                    frame_timer = 0;
                }
                image_index = 8 + frame_index;
            } else {
                image_index = 7;
                frame_index = 0;
                frame_timer = 0;
                frame_forward = true;
            }
        break;

        // ================================
        // UP (idle 11, walk frames 12,13)
        // ================================
        case 3: // up
    if (move_y < 0) {
        if (frame_timer >= frame_delay_ud) {
            frame_index = (frame_index + 1) mod 4; // 0,1,2,3 cycle
            frame_timer = 0;
        }

        switch (frame_index) {
            case 0: image_index = 12; break; // walk1
            case 1: image_index = 11; break; // idle
            case 2: image_index = 13; break; // walk2
            case 3: image_index = 11; break; // idle
        }
    } else {
        image_index = 11; // idle
        frame_index = 0;
        frame_timer = 0;
    }
break;

    }

    // reset scale
    image_xscale = 1;
    image_yscale = 1;

    // movement
    move_and_collide(move_x, move_y, obj_inviswall, 4, 0, 0, move_speed, -1);
}
