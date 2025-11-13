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
    if (!variable_instance_exists(id, "frame_forward")) frame_forward = true;

    // --- Frame delays ---
    var frame_delay_lr = 20; // faster left/right
    var frame_delay_ud = 16; // normal up/down

    // --- Animation handling ---
    frame_timer += 1;

    switch (animdir) {
        case 0: // down
            if (move_y > 0) {
                if (frame_timer >= frame_delay_ud) {
                    frame_index = (frame_index + 1) mod 2;
                    frame_timer = 0;
                }
                image_index = 1 + frame_index; // 1, 2
            } else {
                image_index = 0; // idle down
                frame_index = 0;
                frame_timer = 0;
            }
            break;

        case 1: // left
            if (move_x < 0) {
                if (frame_timer >= frame_delay_lr) {
                    // ping-pong logic
                    if (frame_forward) frame_index += 1; else frame_index -= 1;
                    if (frame_index >= 2) { frame_index = 2; frame_forward = false; }
                    if (frame_index <= 0) { frame_index = 0; frame_forward = true; }
                    frame_timer = 0;
                }
                image_index = 4 + frame_index; // 4,5,6
            } else {
                image_index = 3; // idle left
                frame_index = 0;
                frame_timer = 0;
                frame_forward = true;
            }
            break;

        case 2: // right
            if (move_x > 0) {
                if (frame_timer >= frame_delay_lr) {
                    // ping-pong logic
                    if (frame_forward) frame_index += 1; else frame_index -= 1;
                    if (frame_index >= 2) { frame_index = 2; frame_forward = false; }
                    if (frame_index <= 0) { frame_index = 0; frame_forward = true; }
                    frame_timer = 0;
                }
                image_index = 8 + frame_index; // 8,9,10
            } else {
                image_index = 7; // idle right
                frame_index = 0;
                frame_timer = 0;
                frame_forward = true;
            }
            break;

        case 3: // up
            if (move_y < 0) {
                if (frame_timer >= frame_delay_ud) {
                    frame_index = (frame_index + 1) mod 2;
                    frame_timer = 0;
                }
                image_index = 12 + frame_index; // 12,13
            } else {
                image_index = 11; // idle up
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
