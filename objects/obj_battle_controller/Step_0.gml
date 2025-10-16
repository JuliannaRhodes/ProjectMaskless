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
				rhythm_timer = room_speed * 10; // <-- 10-second timer
            break;

            case "Defend":
                global.current_action = "DEFEND"; 
                battle_phase = BattlePhase.RHYTHM;
                frame_counter = 0;
                note_counter = 0;
                beat_counter = 0;
                audio_play_sound(snd_lekemusic, 1, false);
				 rhythm_timer = room_speed * 10; // <-- 10-second timer
            break;

            case "Item":
                show_debug_message("Used an item!");
            break;

            case "Run":
				if (instance_exists(obj_gamecontroller)) {
				room_goto(obj_gamecontroller.prevRoom);
					} else {
						show_debug_message("No controller found!");
					}
			break;
        }
    }
} 



var lane_height = 50;
var spawn_y_offset = 550; // pushes notes down

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
            instance_create_layer(1200, 750, "Instances", obj_reed);
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