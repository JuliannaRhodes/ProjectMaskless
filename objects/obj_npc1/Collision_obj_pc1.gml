

if (instance_exists(obj_battle_switcher)) exit;

var _switcher = instance_create_depth (0, 0,  0, obj_battle_switcher);
// Switch the player to battle state
with (obj_pc1) {
    state = player_state_battle; // assign the battle state script
}

_switcher.player_data = self;
_switcher.enemy_data = other;
_switcher.original_room = room;

room_goto(rm_battle);