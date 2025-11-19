/// --- BACKGROUND AND VISIBILITY ---
if (battle_phase == BattlePhase.MENU) {
    layer_background_sprite(bg_layer_id, spr_bg_battlemenu);

    // Hide GH buttons and reed notes
    with (obj_btn_k) visible = false;
    with (obj_btn_f) visible = false;
    with (obj_btn_j) visible = false;
    with (obj_btn_d) visible = false;
    with (obj_reed) visible = false;

    // Show action buttons
    with (obj_action_attack) visible = true;
    with (obj_action_defend) visible = true;
    with (obj_action_item) visible  = true; 
    with (obj_action_run) visible = true;

    // Destroy all rhythm objects
    with (obj_note_falling) instance_destroy();
    with (obj_reed) instance_destroy();
}
else if (battle_phase == BattlePhase.RHYTHM) {
    layer_background_sprite(bg_layer_id, spr_bg_battlerhythm);

    // Show GH buttons and reed notes
    with (obj_btn_k) visible = true;
    with (obj_btn_f) visible = true;
    with (obj_btn_j) visible = true;
    with (obj_btn_d) visible = true;
    with (obj_reed) visible = true;

    // Hide action buttons
    with (obj_action_attack) visible = false;
    with (obj_action_defend) visible = false;
    with (obj_action_item) visible  = false; 
    with (obj_action_run) visible = false;
}

// --- PLAYER FLASH TIMER ---
if (player_flash_timer > 0) {
    player_flash_timer--;
}

/// --- MENU INPUT ---
if (battle_phase == BattlePhase.MENU) {
    // Play menu bass if not playing
    if (!audio_is_playing(snd_bass)) {
        audio_play_sound(snd_bass, 1, true);
    }

    // Move selection left/right
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up)) {
        audio_play_sound(snd_button, 1, false);
        menu_choice = (menu_choice - 1 + array_length(menu_options)) mod array_length(menu_options);
    }
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) {
        audio_play_sound(snd_button, 1, false);
        menu_choice = (menu_choice + 1) mod array_length(menu_options);
    }

    // Confirm selection
    if (keyboard_check_pressed(vk_enter)) {
        var choice = menu_options[menu_choice];
        audio_stop_sound(snd_bass);

        switch (choice) {
            case "Attack":
                global.current_action = "ATTACK"; 
                battle_phase = BattlePhase.RHYTHM;
                frame_counter = 0;
                note_counter = 0;
                beat_counter = 0;
                frame_beat_counter = frame_beat_counter_total;
                audio_play_sound(snd_song_p1, 1, false);
                rhythm_timer = room_speed * 15;
            break;

            case "Defend":
                global.current_action = "DEFEND"; 
                battle_phase = BattlePhase.RHYTHM;
                frame_counter = 0;
                note_counter = 0;
                beat_counter = 0;
                frame_beat_counter = frame_beat_counter_total;
                audio_play_sound(snd_song_p1, 1, false);
                rhythm_timer = room_speed * 15;
            break;

            case "Item":
                battle_phase = BattlePhase.ITEM_MENU;
                item_selected = 0;
            break;

            case "Run":
                room_goto(obj_battle_switcher.original_room);
            break;
        }
    }
}
/// --- RHYTHM PHASE ---
var lane_height = 45;
var spawn_y_offset = 470; // adjusts Y position of notes

if (battle_phase == BattlePhase.RHYTHM) {
    // --- Rhythm timer ---
    rhythm_timer--;
    if (rhythm_timer <= 0) {
        battle_phase = BattlePhase.MENU;
        audio_stop_sound(snd_song_p1);
        audio_stop_sound(snd_song_p2);
        exit;
    }

    // --- Switch music if enemy HP < half ---
    if (global.npc1_hp <= 500) {  // half of 500
        if (audio_is_playing(snd_song_p1)) {
            audio_stop_sound(snd_song_p1);
            audio_play_sound(snd_song_p2, 1, false);
        }
    }

    // --- Frame/beat counter ---
    frame_beat_counter--;
    if (frame_beat_counter <= 0) {
        frame_beat_counter = frame_beat_counter_total;
        beat_counter += 0.5; // support fractional beats

        // --- Spawn reed ---
        if (beat_counter mod 1 == 0) {
            var new_reed = instance_create_layer(1200, 675, "Instances", obj_reed);

            // Spawn a note attached to this reed if there is a note in the array for this beat
            if (note_counter < array_length(global.notes_arr)) {
                var next_note = global.notes_arr[note_counter];
                
                // Check if this note's beat matches current beat (allow fractional)
                if (next_note[0] <= beat_counter) {
                    var lane = next_note[1];
                    if (lane >= 1 && lane <= 4) {
                        // Position note relative to lane
                        var new_note_y = lane * lane_height + spawn_y_offset;
                        var new_note = instance_create_layer(new_reed.x, new_note_y, "Instances", obj_note_falling);
                        new_note.image_index = lane;
                    }
                    note_counter++; // move to next note
                }
            }
        }
    }

    // --- Draw score UI ---
    score_to_draw = pad_score(global.points, 5);

    // --- End rhythm if all notes are done + buffer ---
    if (note_counter >= array_length(global.notes_arr) && beat_counter > array_length(global.notes_arr) + 8) {
        battle_phase = BattlePhase.MENU;
        audio_stop_sound(snd_song_p1);
        audio_stop_sound(snd_song_p2);
    }
}


/// --- ITEM MENU ---
if (battle_phase == BattlePhase.ITEM_MENU) {
    // Flatten inventory
    var total_lines = 0;
    for (var i = 0; i < array_length(global.inventory); i++) {
        total_lines += global.inventory[i].amount;
    }

    // Navigate
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left)) {
        item_selected = (item_selected - 1 + total_lines) mod total_lines;
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_right)) {
        item_selected = (item_selected + 1) mod total_lines;
    }

    // Use item
    if (keyboard_check_pressed(vk_enter)) {
        var line_counter = 0;
        for (var i = 0; i < array_length(global.inventory); i++) {
            var item = global.inventory[i];
            for (var j = 0; j < item.amount; j++) {
                if (line_counter == item_selected) {
                    if (item.name == "Health Potion") {
                        global.player_hp = clamp(global.player_hp + 25, 0, global.player_max_hp);
                        item.amount -= 1;
                        show_debug_message("Used Health Potion! Restored 25 HP.");
                        if (item.amount <= 0) array_delete(global.inventory, i, 1);
                    }
                }
                line_counter++;
            }
        }
    }

    // Cancel back to menu
    if (keyboard_check_pressed(vk_escape)) {
        battle_phase = BattlePhase.MENU;
    }
}
