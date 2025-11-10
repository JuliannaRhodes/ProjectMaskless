    // Stop chatterbox and clear dialogue so text disappears immediately
	instance_create_layer(0,0,"fade", obj_fadeout);
    ChatterboxStop(chatterbox);
    current_text = "";
    current_text_index = 0;
    currently_talking = noone;
