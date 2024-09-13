if (keyboard_check_pressed(vk_space)) {
	game_set_speed(game_get_speed(gamespeed_fps) != 30 ? 30 : 120, gamespeed_fps);
}

if (keyboard_check_pressed(vk_control)) {
	Time.speed = (Time.speed != 1) ? 1 : 0.25;
}