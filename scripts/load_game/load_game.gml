function load_game() {
    if (file_exists("savefile.dat")) {
        var buffer = buffer_load("savefile.dat");
        
        buffer_seek(buffer, buffer_seek_start, 0);
        obj_pc1.x = buffer_read(buffer, buffer_f32);
        obj_pc1.y = buffer_read(buffer, buffer_f32);
        global.player_hp = buffer_read(buffer, buffer_u16);
        var saved_room = buffer_read(buffer, buffer_string);
        global.npc1_hp = buffer_read(buffer, buffer_u16);
        
        buffer_delete(buffer);
        show_message("Game has been loaded");
    }
    else {
        show_message("File does not exist");
    }
}
