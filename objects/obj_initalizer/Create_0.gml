global.starting_x = 192;
global.starting_y = 352;

global.starting_room = rm_main;
if (room == rm_start) {
    global.x = global.starting_x;
    global.y = global.starting_y;
}


// --- Rhythm game settings ---
global.difficulty = 2;  // not used now, optional later

// --- Manual notes array ---
// Each note: [beat_number, lane_number]
// You can pick which note on which beat. Fractional beats are fine (e.g., 1.5 = eighth note)
global.notes_arr = [
	[1, 1],
    [2, 2],
    [3, 1],
    [4, 3],
    [5, 2],
    [6, 1],
    [7, 4],
    [8, 2],
    [9, 3],
    [10, 1],
    [11, 4],
    [12, 4],
    [13, 2],
    [14, 1],
    [15, 1],
    [16, 3],
    [17, 4],
    [18, 1],
    [19, 2],
    [20, 3],
    [21, 4],
    [22, 3],
    [23, 2],
    [24, 1],
    [25, 4],
    [26, 4],
    [27, 2],
    [28, 3],
    [29, 4],
    [30, 1]
];

// --- Rhythm counters ---
note_counter = 0;  // which note in array we're on
beat_counter = 0;  // current beat
frame_beat_counter_total = room_speed * 60 / 120; // 120 BPM
frame_beat_counter = frame_beat_counter_total;

// --- Move speed of notes ---
global.move_speed = 8;  // adjust to match rhythm visually

