// --- Get globals ---
var phase = global.current_action;

// --- Initialize global hit locks (once per step) ---
if (!variable_global_exists("note_hit_lock")) {
    global.note_hit_lock = array_create(5, false);
}


// --- Move note ---
x -= global.move_speed;

// --- Calculate distance to hitbox ---
var x_distance = abs(x - obj_hitbox.x);

// --- Check for hits using keyboard just pressed ---
var hit_registered = false;
switch (image_index) {
    case 1: if (!global.note_hit_lock[1] && keyboard_check_pressed(ord("D"))) hit_registered = true; break;
    case 2: if (!global.note_hit_lock[2] && keyboard_check_pressed(ord("F"))) hit_registered = true; break;
    case 3: if (!global.note_hit_lock[3] && keyboard_check_pressed(ord("J"))) hit_registered = true; break;
    case 4: if (!global.note_hit_lock[4] && keyboard_check_pressed(ord("K"))) hit_registered = true; break;
}


var hit_success = false; // track if note was hit

if (hit_registered) {
    if (x_distance <= 100) {
        // --- Accuracy grading ---
        var accuracy = "";
        if (x_distance >= 0 && x_distance <= 25) accuracy = "PERFECT";
        else if (x_distance <= 50) accuracy = "NICE";
        else if (x_distance <= 75) accuracy = "OKAY";
        else accuracy = "MISS";

        // Only treat as success if accuracy is not MISS
        if (accuracy != "MISS") {
            hit_success = true;
				
		// Lock this color for this frame
		global.note_hit_lock[image_index] = true;

            var damage_to_enemy = 0;
            var damage_to_player = 0;

            switch (phase) {
                case "ATTACK":
                    switch (accuracy) {
                        case "OKAY":    damage_to_enemy = 4;  break;
                        case "NICE":    damage_to_enemy = 6;  break;
                        case "PERFECT": damage_to_enemy = 15; break;
                    }
                    break;

                case "DEFEND":
                    switch (accuracy) {
                        case "OKAY":    damage_to_enemy = 1;  break;
                        case "NICE":    damage_to_enemy = 4;  break;
                        case "PERFECT": damage_to_enemy = 6;  break;
                    }
                    break;
            }

            // --- Apply damage ---
            global.npc1_hp -= damage_to_enemy;
            hurt_player(damage_to_player); 
            global.npc1_hp = clamp(global.npc1_hp, 0, global.npc1_max_hp);
            global.player_hp = clamp(global.player_hp, 0, global.player_max_hp);

            // --- Feedback ---
            var nicejob = instance_create_layer(550, 200, "Instances", obj_nicejob);
            nicejob.text_to_draw = accuracy;

            instance_destroy(); // destroy note only on successful hit
        } else {
            // MISS in hit zone, counts as late miss
            // handled below when note passes hitbox
        }

    } else if (x_distance > 100 && x_distance <= 100000) {
        // --- Early press — note still falling ---
        var badhit = instance_create_layer(550, 200, "Instances", obj_nicejob);
        var damage_to_player = 0;
        
        switch (phase) {
            case "ATTACK":
                damage_to_player = 15; // Adjust as needed
                badhit.text_to_draw = "Miss Fire! Too early!";
                break;

            case "DEFEND":
                damage_to_player = 2;
                badhit.text_to_draw = "Miss Fire! Too early!";
                break;
        }

        hurt_player(damage_to_player);
        instance_destroy();
    }
}

// --- Late miss: note passed hitbox without successful hit ---
if (!hit_success && x < obj_hitbox.x - 100) {
    var badhit = instance_create_layer(550, 200, "Instances", obj_nicejob);
    var damage_to_player = 0;

    switch (phase) {
        case "ATTACK":
            damage_to_player = 15;
            badhit.text_to_draw = "Miss! You took 15 damage!";
            break;

        case "DEFEND":
            damage_to_player = 2;
            badhit.text_to_draw = "Miss! You got hit (2 dmg)!";
            break;
    }

    hurt_player(damage_to_player);
    instance_destroy();
    exit;
}

// --- Destroy if offscreen to the far right (cleanup) ---
if (x > room_width + 25) {
    instance_destroy();
    exit;
}

// --- End-of-turn check ---
if (instance_number(obj_note_falling) == 0) {
    global.turn_phase = "ENEMY";
}
