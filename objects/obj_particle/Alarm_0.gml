// Alarm[0] Event

// Get camera bounds
var get_cameraX = camera_get_view_x(view_camera[0]);
var get_cameraY = camera_get_view_y(view_camera[0]);
var get_camera_width = camera_get_view_width(view_camera[0]);
var get_camera_height = camera_get_view_height(view_camera[0]);
var buffer = 40;

// Spawn a few sparkles at random positions around the camera
var amount = irandom_range(1, 5);
repeat(amount) {
    var randomX = random_range(get_cameraX - buffer, get_cameraX + get_camera_width + buffer);
    var randomY = random_range(get_cameraY - buffer, get_cameraY + get_camera_height + buffer);

    if (particle_system != 0) {  // only spawn if system exists
        part_particles_create(particle_system, randomX, randomY, part_sparkle, 1);
    }
}

// Repeat the alarm every step
alarm[0] = 1;