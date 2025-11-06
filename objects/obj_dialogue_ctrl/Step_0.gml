// --- Step Event ---

var check_radius = 64;
var nearest_dist = 9999;
var nearest_npc = noone;

// --- Find nearest NPC ---
with (obj_npcs) {
    var dist_to_player = point_distance(obj_pc1.x, obj_pc1.y, x, y);
    if (dist_to_player < nearest_dist && dist_to_player <= check_radius) {
        nearest_dist = dist_to_player;
        nearest_npc = id;
    }
}

// --- Get number of dialogue options ---
var _count = ChatterboxGetOptionCount(chatterbox);

// --- Get input ---
var enter_pressed = keyboard_check_pressed(vk_enter);

// --- Dialogue logic ---
if (enter_pressed) {
    if (nearest_npc != noone && ChatterboxIsStopped(chatterbox)) {
        // Start dialogue
        currently_talking = nearest_npc;
        ChatterboxJump(chatterbox, nearest_npc.node_name);
        chatterbox_update();
        current_text = ChatterboxGetContent(chatterbox, 0);
        current_text_index = 0;
        option_index = 0;
        active = true;
    }
    else if (_count > 0 && !ChatterboxIsWaiting(chatterbox)) {
        // Select an option if available
        ChatterboxSelect(chatterbox, option_index);
        chatterbox_update();
        option_index = 0;

        if (!ChatterboxIsStopped(chatterbox)) {
            current_text = ChatterboxGetContent(chatterbox, 0);
            current_text_index = 0;
        } else {
            // Dialogue ended
            current_text = "";
            currently_talking = noone;
            active = false;
        }
    }
    else if (!ChatterboxIsStopped(chatterbox) && ChatterboxIsWaiting(chatterbox)) {
        // Continue dialogue if waiting
        ChatterboxContinue(chatterbox);
        chatterbox_update();
    }
}

// --- Option navigation ---
var _count = ChatterboxGetOptionCount(chatterbox);
if (_count > 0 && !ChatterboxIsWaiting(chatterbox)) {
    var _key = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    if (_key != 0) {
        repeat (1 + (ChatterboxGetOptionConditionBool(chatterbox, wrap(option_index + _key, 0, _count - 1)) == false)) {
            option_index = wrap(option_index + _key, 0, _count - 1);
        }
    }
}

// --- Stop dialogue if player walks too far ---
if (currently_talking != noone && instance_exists(currently_talking) && instance_exists(obj_pc1)) {
    var dist = point_distance(obj_pc1.x, obj_pc1.y, currently_talking.x, currently_talking.y);
    if (dist > 96) {
        ChatterboxStop(chatterbox);
        current_text = "";
        current_text_index = 0;
        currently_talking = noone;
        active = false;
    }
}