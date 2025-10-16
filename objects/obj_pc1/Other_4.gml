if (variable_global_exists("spawn_x")) {
    x = global.spawn_x;
    y = global.spawn_y;
} else {
    x = starting_x;
    y = starting_y;
}

if (instance_exists(obj_npc1) && global.npc1_hp <= 0)
with (obj_npc1)
{
    instance_destroy();
}
