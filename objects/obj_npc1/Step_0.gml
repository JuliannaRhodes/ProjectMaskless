// PUT ON STEP EVENT

if (obj_pc1.key_int1_press==1) && (distance_to_object(obj_pc1)<=range) 
        {
        txtbox = 1;
        }


if (txtbox<>0) && (distance_to_object(obj_pc1)>range)
    {
    txtbox = 0;
    }

if (global.npc1_hp <= 0 && !global.battle_ending) {
    global.battle_ending = true; // prevents multiple triggers
	audio_stop_all();
    // optionally play death animation here
	enemy_dead();
	instance_destroy();

}
// END STEP EVENT
