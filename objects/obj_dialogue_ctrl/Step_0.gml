// naviate text and options

var _count = ChatterboxGetOptionCount(chatterbox);    // get the number of options we have

if ChatterboxIsWaiting(chatterbox) and keyboard_check_pressed(vk_space)   // is chatterbox waiting for user input
{
	ChatterboxContinue(chatterbox);
	chatterbox_update();
}
else if _count // is chatterbox presenting the user with options
{
	var _key = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)    // var will be 1 if down is pressed -1 if up is pressed and both or neither is 0
	
	// Move option_index twice if next option is invalid
	
	repeat (1 + (ChatterboxGetOptionConditionBool(chatterbox, wrap(option_index + _key, 0, _count - 1)) == false))
	{
		option_index = wrap(option_index + _key, 0, _count -1);
	}
	
	if keyboard_check_pressed(vk_space)
	{
		ChatterboxSelect(chatterbox, option_index);
		option_index = 0;
		
		chatterbox_update();
	}
}

if ChatterboxIsStopped(chatterbox) // end when reached end of chatterbox
{
	instance_destroy();
}