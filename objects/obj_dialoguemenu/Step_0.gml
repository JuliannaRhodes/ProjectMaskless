// Get input
up_key= keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_enter);

var _count = ChatterboxGetOptionCount(chatterbox);


// --- If Chatterbox is waiting (no options) ---
if (ChatterboxIsWaiting(chatterbox) && keyboard_check_pressed(vk_space)) {
    ChatterboxContinue(chatterbox);
    chatterbox_update();
}


// --- If Chatterbox has options ---
else if (_count > 0) {

    // Get arrow key input
    var _key = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	
	   // Only update option index if there is input
    if (_key != 0) {
        // Wrap option index and skip unavailable options
        repeat(_count) {
            option_index = wrap(option_index + _key, 0, _count - 1);
            if (ChatterboxGetOptionConditionBool(chatterbox, option_index)) break;
        }
    }

    // Select option if Space is pressed
    if (keyboard_check_pressed(vk_space)) {
        ChatterboxSelect(chatterbox, option_index);
        option_index = 0; // reset index after selection
        chatterbox_update();
    }
}