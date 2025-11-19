global.x = global.starting_x;
global.y = global.starting_y;

up_key     = keyboard_check_pressed(vk_up);
down_key   = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_enter);

// number of options in this menu
op_length = array_length(option[menu_level]);

var moved = (up_key || down_key);

if (moved) {
    pos += down_key - up_key;

    // play move sound
    audio_play_sound(snd_button, 1, false);
}

// wrap cursor
if (pos >= op_length) pos = 0;
if (pos < 0)          pos = op_length - 1;


if (accept_key) {
    
    // play confirm sound
    audio_play_sound(snd_rollup, 1, false);

    var _sml = menu_level;

    switch (menu_level) {

        case 0:
            switch (pos) {

                // Restart game
                case 0:
                    instance_create_layer(0,0,"fade", obj_fadeout);

                    spawn_player(global.starting_x, global.starting_y);
                    room_goto(rm_start);
                break;

                // Settings
                case 1:
                    menu_level = 1;
                break;

                // Quit game
                case 2:
                    game_end();
                break;
            }
        break;
        case 1:
            switch (pos) {

                case 0: /* window size */ break;
                case 1: /* brightness */ break;
                case 2: /* controls */ break;

                case 3:
                    menu_level = 0; // back
                break;
            }
        break;
    }

    // if we changed menu levels, reset cursor
    if (_sml != menu_level)
        pos = 0;

    // update length
    op_length = array_length(option[menu_level]);
}
