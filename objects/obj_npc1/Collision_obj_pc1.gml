

if (instance_exists(obj_battle_switcher)) exit;

var _switcher = instance_create_depth (0, 0,  0, obj_battle_switcher);
// Switch the player to battle state


_switcher.player_data = self;
_switcher.enemy_data = other;
_switcher.original_room = room;
// Before entering battle
global.x = obj_pc1.x;
global.y = obj_pc1.y;




room_goto(rm_battle);