

if (instance_exists(obj_npc1) && global.npc1_hp <= 0)
with (obj_npc1)
{
    instance_destroy();
}
