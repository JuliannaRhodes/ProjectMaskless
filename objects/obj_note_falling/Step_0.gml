// --- Get globals ---
var phase = global.current_action;

// --- Correct fret check ---
is_correct_fret = false;
if (image_index == 1 && global.green_pressed) is_correct_fret = true;
if (image_index == 2 && global.red_pressed) is_correct_fret = true;
if (image_index == 3 && global.orange_pressed) is_correct_fret = true;
if (image_index == 4 && global.blue_pressed) is_correct_fret = true;

// --- Move note ---
x -= global.move_speed;
if x < -25 || x > room_width + 25 { instance_destroy(); }

// --- Check hit ---
if (keyboard_check_pressed(vk_space)) {
    var x_distance = abs(x - obj_hitbox.x);

    if is_correct_fret && x_distance <= 100 {
        var hp_change, score_change, message;

        if x_distance <= 25 { hp_change = 15; score_change = 100; message = "PERFECT!"; }
        else if x_distance <= 50 { hp_change = 10; score_change = 70; message = "Nice!"; }
        else if x_distance <= 75 { hp_change = 5; score_change = 40; message = "Okay"; }
        else { hp_change = 2; score_change = 10; message = "Bad"; }

        // Apply HP
        if phase == "ATTACK" {
            global.npc1_hp -= hp_change;
            global.npc1_hp = clamp(global.npc1_hp, 0, global.npc1_max_hp);
        } else if phase == "DEFEND" {
            global.player_hp += hp_change;
            global.player_hp = clamp(global.player_hp, 0, global.player_max_hp);
        }

        // Update score
        global.points += score_change;

        // Feedback
        var nicejob = instance_create_layer(550, 200, "Instances", obj_nicejob);
        nicejob.text_to_draw = message;

        instance_destroy();
    }
}

