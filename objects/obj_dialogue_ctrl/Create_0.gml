// --- Dialogue controller variables ---
active = false;                  // whether a conversation is currently active
chatterbox = noone;              // the current chatterbox instance
currently_talking = noone;       // the NPC instance player is talking to
current_text = "";               // current line of dialogue to draw
current_text_index = 0;          // character index for typewriter effect
current_text_line_number = 0;    // optional: tracks which line in chatterbox

option_index = 0;                // selected menu option

// --- UI layout ---
op_border = 8;                   // padding inside box
op_space = 28;                   // spacing between options
width = 0;
height = 0;

// --- Load chatterbox file ---
ChatterboxLoadFromFile("TestDialogue.yarn");
chatterbox = ChatterboxCreate("TestDialogue.yarn");