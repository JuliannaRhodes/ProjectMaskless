

particle_system = part_system_create_layer("effects", 0);
part_sparkle = part_type_create();
part_type_sprite(part_sparkle, spr_particle, 1, 0, 1);
part_type_size(part_sparkle, 0.5, 1.5, 0, 0);

part_type_color3(part_sparkle, c_white, c_gray, c_white)
part_type_alpha3(part_sparkle, 0.2, 0.5, 0.2);
part_type_life(part_sparkle, 120, 180);
part_type_direction(part_sparkle, 89, 91, 0, 0);
part_type_speed(part_sparkle, 0.05, 0.1, 0, 0);
alarm[0] = 40;

