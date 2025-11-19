// get inputs
with (obj_pc1) state = player_state_menus;
up_key    = keyboard_check_pressed(vk_up);
down_key  = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_enter);

// store number of options in current menu
op_length = array_length(option[menu_level]);


// only play move SFX if you actually move
var moved = (up_key || down_key);

if (moved) {
    pos += down_key - up_key;
    audio_play_sound(snd_button, 1, false);
}

if pos >= op_length { pos = 0; }
if pos  < 0        { pos = op_length - 1; }


if (accept_key) {
    
    // play confirm sound
    audio_play_sound(snd_rollup, 1, false);

    var _sml = menu_level;

    switch(menu_level) {
    
        case 0:
            switch(pos) {

                // start game
                case 0:
                    instance_create_layer(0,0,"fade", obj_fadeout);
                    room_goto(global.room_name);
                break;

                // settings
                case 1:
                    menu_level = 1;
                break;

                // quit game
                case 2:
                    game_end();
                break;
            }
        break;

        case 1:
            switch(pos) {
                
                case 0:
                    // window size
                break;

                case 1:
                    // brightness
                break;

                case 2:
                    // controls
                break;

                case 3:
                    // back
                    menu_level = 0;
                break;
            }
        break;
    }

    // reset cursor if menu layer changed
    if (_sml != menu_level) pos = 0;

    // update option count
    op_length = array_length(option[menu_level]);
}
