// --- Dialogue controller variables ---
active = false;
chatterbox = noone;
currently_talking = noone;
current_text = "";
current_text_index = 0;
current_text_line_number = 0;
option_index = 0;
text_clear_pending = false;
global.entering_battle = false;
global.dialogue_locked = false;

// --- UI layout ---
op_border = 8;
op_space = 28;
width = 0;
height = 0;

scribble_object = scribble(current_text)
	.starting_format("fnt_jersey", c_white)
	
typist = scribble_typist();
typist.in(0.4, 0.5);
typist.sound_per_char([snd_typing3, snd_typing2, snd_typing3], 1, 1, " .,?!aeiou");


// --- Load chatterbox file ---
ChatterboxLoadFromFile("TestDialogue.yarn");

// Define custom functions BEFORE creating the chatterbox
scribble_typists_add_event("StartBattle", function() {
    if (instance_exists(obj_battle_switcher)) exit;
	    global.dialogue_locked = true;
    
    // Stop current chatterbox typing
    if (instance_exists(obj_dialogue_ctrl) && obj_dialogue_ctrl.chatterbox != noone) {
        ChatterboxStop(obj_dialogue_ctrl.chatterbox); // stops current dialogue
        obj_dialogue_ctrl.active = false;
        obj_dialogue_ctrl.current_text = "";
    }

    // Create battle switcher object
	global.entering_battle = true;
    var _switcher = instance_create_depth(0, 0, 0, obj_battle_switcher);
    _switcher.player_data = obj_pc1;
    _switcher.enemy_data = currently_talking;
    _switcher.original_room = room;

    // Store player position for returning later
    global.x = obj_pc1.x;
    global.y = obj_pc1.y;
	
  with (obj_dialogue_ctrl) {	
	alarm[1] = 40;
	}
    // Trigger a short delay before switching to battle room
    with (obj_dialogue_ctrl) {
        alarm[0] = 100; // 15 frames = ~0.25 seconds
    }
});

// Now create the chatterbox instance
chatterbox = ChatterboxCreate("TestDialogue.yarn");