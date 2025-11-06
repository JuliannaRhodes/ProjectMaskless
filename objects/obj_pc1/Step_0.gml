// on step


// get keyboard input
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_int1_press = keyboard_check_pressed(vk_enter);
key_int1_hold  = keyboard_check(vk_enter);

// player state
state();
if (room == rm_main) {
    state = player_state_free;
}
if (room == rm_battle) {
    state = player_state_menus;
}


if (key_int1_press == 1) {

    if (ChatterboxIsStopped(chatterbox)) {

        var check_radius = 64; // how far player can reach
        var nearest_dist = 9999;
        var who_is_here = noone;

        // Loop through all NPCs (obj_npcs = parent object)
        with (obj_npcs) {
            var dist_to_player = point_distance(other.x, other.y, x, y);
            if (dist_to_player <= check_radius) {
                if (dist_to_player < nearest_dist) {
                    nearest_dist = dist_to_player;
                    who_is_here = id; // store the NPC instance
                }
            }
        }

        if (who_is_here != noone) {
            ChatterboxJump(chatterbox, who_is_here.node_name);
            currently_talking = who_is_here;
        }

    } else if (ChatterboxIsWaiting(chatterbox)) {
        ChatterboxContinue(chatterbox);
    }

    if (!ChatterboxIsStopped(chatterbox)) {
        current_text = ChatterboxGetContent(chatterbox, 0);
        current_text_index = 0;
    } else {
        current_text = "";
        currently_talking = noone;
    }
}


// --- Check if player walked too far away ---
if (currently_talking != noone) {
    var dist = point_distance(x, y, currently_talking.x, currently_talking.y);
    
    if (dist > 96) { // adjust this number to your liking (96px = about 3 tiles)
        ChatterboxStop(chatterbox); // end dialogue safely
        current_text = "";
        currently_talking = noone;
    }
}


// end step