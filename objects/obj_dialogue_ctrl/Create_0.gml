// Initalize chatterbox and set variables

ChatterboxLoadFromFile("TestDialogue.yarn");  // load file
ChatterboxAddFunction("bg", baackground_set_index);   // add function to change background index
chatterbox = ChatterboxCreate();   // create a chatterbox
ChatterboxJump(chatterbox, "Start");    // go to start node
chatterbox_update();      // get current node and current node text

option_index = 0;       // initalize option index

size = [0.7, 0.75];    // character sprite scale (small for not speaking and large for speaking)
color = [c_ltgray, c_white];      // character sprite blend (dark for not speaking white for speaking)


