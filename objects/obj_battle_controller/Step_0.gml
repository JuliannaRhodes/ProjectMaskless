if (battle_phase == BattlePhase.MENU) {
    layer_background_sprite(bg_layer_id, spr_bg_battlemenu);
	 // Hide GH buttons
    with (obj_btn_blue) visible = false;
    with (obj_btn_red) visible = false;
    with (obj_btn_orange) visible = false;
    with (obj_btn_green) visible = false;
	with (obj_reed) visible = false;
	with (obj_action_attack) visible  = true;
	with (obj_action_defend) visible = true;
	with (obj_action_item) visible = true; 
	with (obj_action_run) visible = true;
	// Destroy all rhythm objects
	with (obj_note_falling) instance_destroy();
	with (obj_reed) instance_destroy();
}
else if (battle_phase == BattlePhase.RHYTHM) {
    layer_background_sprite(bg_layer_id, spr_bg_battlerhythm);
	 // Show GH buttons
    with (obj_btn_blue) visible = true;
    with (obj_btn_red) visible = true;
    with (obj_btn_orange) visible = true;
    with (obj_btn_green) visible = true;
	with (obj_reed) visible = true;
	with (obj_action_attack) visible  = false;
	with (obj_action_defend) visible = false;
	with (obj_action_item) visible = false; 
	with (obj_action_run) visible = false;
}

if (player_flash_timer > 0) {
    player_flash_timer--;
}

//MENU INPUT
if (battle_phase == BattlePhase.MENU) {
    // Move selection left/right
	if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up)) {
        menu_choice = (menu_choice - 1 + array_length(menu_options)) mod array_length(menu_options);
    }
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) {
        menu_choice = (menu_choice + 1) mod array_length(menu_options);
    }

    // Confirm selection
    if (keyboard_check_pressed(vk_enter)) {
        var choice = menu_options[menu_choice];

        switch (choice) {
            case "Attack":
                global.current_action = "ATTACK"; 
                battle_phase = BattlePhase.RHYTHM;
                frame_counter = 0;
                note_counter = 0;
                beat_counter = 0;
                audio_play_sound(snd_lekemusic, 1, false);
				rhythm_timer = room_speed * 15; // <-- 10-second timer
            break;

            case "Defend":
                global.current_action = "DEFEND"; 
                battle_phase = BattlePhase.RHYTHM;
                frame_counter = 0;
                note_counter = 0;
                beat_counter = 0;
                audio_play_sound(snd_lekemusic, 1, false);
				 rhythm_timer = room_speed * 15; // <-- 10-second timer
            break;

            case "Item":
					battle_phase = BattlePhase.ITEM_MENU;
					item_selected = 0;
					
            break;

            case "Run":
                room_goto(obj_battle_switcher.original_room)
            break;
        }
    }
} 



var lane_height = 45;
var spawn_y_offset = 470; // pushes notes down

// Only run rhythm logic if in rhythm phase
if (battle_phase == BattlePhase.RHYTHM) {
	
	  // --- Timer ---
    rhythm_timer--;
    if (rhythm_timer <= 0) {
        battle_phase = BattlePhase.MENU;
        audio_stop_sound(snd_lekemusic);
        exit; // stop rhythm logic once time runs out
    }
    
    // --- Beat/frame counter ---
    if frame_beat_counter > 0 {
        frame_beat_counter--;
    }
    else {
        beat_counter++;
        
        // --- Auto-spawn "reed" notes at adjustable interval ---
        if (beat_counter mod 2 == 0) {
            instance_create_layer(1200, 675, "Instances", obj_reed);
        }

        // --- Spawn notes from global array ---
        // Make sure note_counter is in bounds
        while (note_counter < array_length(global.notes_arr) &&
               beat_counter == global.notes_arr[note_counter][0]) {
            
            var lane = global.notes_arr[note_counter][1];
            
            if (lane >= 1 && lane <= 4) {
                var new_note_y = lane * lane_height + spawn_y_offset;
                var new_note = instance_create_layer(1200, new_note_y, "Instances", obj_note_falling);
                new_note.image_index = lane;
            }

            note_counter++;
        }

        // Reset frame counter for next beat
        frame_beat_counter = frame_beat_counter_total;
    }

    // --- Draw score (UI) ---
    score_to_draw = pad_score(global.points, 5);

    // --- Check if rhythm section is over ---
    // Add extra beats after last note for music to finish
    if beat_counter > array_length(global.notes_arr) + 8 {
        battle_phase = BattlePhase.MENU; // stop rhythm and return to menu
        audio_stop_sound(snd_lekemusic);
    }
}

if (battle_phase == BattlePhase.ITEM_MENU) {
    // Calculate total lines (flattened inventory)
    var total_lines = 0;
    for (var i = 0; i < array_length(global.inventory); i++) {
        total_lines += global.inventory[i].amount;
    }

    // Navigate up/down through flattened list
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left)) {
        item_selected = (item_selected - 1 + total_lines) mod total_lines;
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_right)) {
        item_selected = (item_selected + 1) mod total_lines;
    }

    // Use item
    if (keyboard_check_pressed(vk_enter)) {
        // Map selected line back to inventory entry
        var line_counter = 0;
        for (var i = 0; i < array_length(global.inventory); i++) {
            var item = global.inventory[i];
            for (var j = 0; j < item.amount; j++) {
                if (line_counter == item_selected) {
                    // Use this item
                    if (item.name == "Health Potion") {
                        global.player_hp = clamp(global.player_hp + 25, 0, global.player_max_hp);
                        item.amount -= 1;
                        show_debug_message("Used Health Potion! Restored 25 HP.");
                        // Optional: remove from inventory if amount hits 0
                        if (item.amount <= 0) {
                            array_delete(global.inventory, i, 1);
                        }
                    }
                }
                line_counter++;
            }
        }
    }

    // Cancel back to main menu
    if (keyboard_check_pressed(vk_escape)) {
        battle_phase = BattlePhase.MENU;
    }
}
