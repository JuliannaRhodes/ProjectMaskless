// Move upward
y -= rise_speed;

// Fade out
text_alpha = max(0, text_alpha - fade_speed);

// Destroy when fully transparent
if (text_alpha <= 0) {
    instance_destroy();
}