if (slide_timer < slide_duration) {
    slide_timer += 1;
    var t = slide_timer / slide_duration;
    var eased_t = 1 - power(1 - t, 2); // smooth ease-out
    x = start_x + (target_x - start_x) * eased_t;
}
alpha = lerp(alpha, 1, 0.05);