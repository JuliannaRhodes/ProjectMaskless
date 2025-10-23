global.starting_x = 100; // your starting player X
global.starting_y = 300; // your starting player Y
global.starting_room = rm_main;
if (room == rm_start) {
    global.x = global.starting_x;
    global.y = global.starting_y;
}



global.difficulty = 2 

global.notes_arr = []

// [Beat, Note]

for (var i = 0; i <( 400/global.difficulty); i++) {
		var next_note = 0
		var next_note_color = 0
		
		if i < 4 {
				next_note = (i * global.difficulty) + 8
				next_note_color = 1
		}
		else if i < 8 {
			next_note = (i * global.difficulty) + 8
			next_note_color = 8 - i
		}
		else {
			next_note = (i * global.difficulty) + 16
			next_note_color = irandom(4) + 1
		}
		
	array_push(global.notes_arr,[next_note,next_note_color])
}