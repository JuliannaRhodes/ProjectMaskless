var lane_height = 50;
var spawn_y_offset = 550; // pushes everything down

if frame_beat_counter > 0 {
    frame_beat_counter--;
}
else {
    beat_counter++;

    if beat_counter mod 2 == 0 {
        instance_create_layer(1200, 750, "Instances", obj_reed);
    }

    if beat_counter == global.notes_arr[note_counter][0] {
        var lane = global.notes_arr[note_counter][1];

        // Only spawn notes if lane is 1–4
        if (lane >= 1 && lane <= 4) {
            var new_note_y = lane * lane_height + spawn_y_offset;
            var new_note = instance_create_layer(1200, new_note_y, "Instances", obj_note_falling);
            new_note.image_index = lane;
        }

        // Always increment note_counter to move through the array
        note_counter++;
    }

    frame_beat_counter = 15;
}

score_to_draw = pad_score(global.points, 5);

if beat_counter > array_length(global.notes_arr) + 8 {
    room_goto(rm_end);
}
