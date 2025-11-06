// Dialogue menu
active = false;
option = [];
op_length = 0;
pos = 0;

// Menu styling
op_border = 20;
op_space = 40;

width = 300; // default width
height = 100;

//chatterbox 
current_text = "";
currently_talking = noone;
current_text_index = 0;
current_text_line_number = 0;

chatterbox = ChatterboxCreate("TestDialogue.yarn");