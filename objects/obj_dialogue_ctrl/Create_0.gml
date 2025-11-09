// --- Dialogue controller variables ---
active = false;
chatterbox = noone;
currently_talking = noone;
current_text = "";
current_text_index = 0;
current_text_line_number = 0;
option_index = 0;

// --- UI layout ---
op_border = 8;
op_space = 28;
width = 0;
height = 0;

scribble_object = scribble(current_text)
	.starting_format("fnt_jersey", c_white)
	
typist = scribble_typist();
typist.in(0.6, 0.5);


// --- Load chatterbox file ---
ChatterboxLoadFromFile("TestDialogue.yarn");

// Define custom functions BEFORE creating the chatterbox
scribble_typists_add_event("StartBattle", function() {
    if (instance_exists(obj_battle_switcher)) exit;

    // Create battle switcher object
    var _switcher = instance_create_depth(0, 0, 0, obj_battle_switcher);
    _switcher.player_data = obj_pc1;
    _switcher.enemy_data = currently_talking;
    _switcher.original_room = room;

    // Store player position for returning later
    global.x = obj_pc1.x;
    global.y = obj_pc1.y;

    // Stop chatterbox and clear dialogue so text disappears immediately
    ChatterboxStop(chatterbox);
    current_text = "";
    current_text_index = 0;
    currently_talking = noone;

    // Trigger a short delay before switching to battle room
    with (obj_dialogue_ctrl) {
        alarm[0] = 75; // 15 frames = ~0.25 seconds
    }
});

// Now create the chatterbox instance
chatterbox = ChatterboxCreate("TestDialogue.yarn");