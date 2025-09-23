global.move_speed = 15

global.green_pressed = false
global.red_pressed = false
global.orange_pressed = false
global.blue_pressed = false

global.level = 0
global.points = 0

frame_counter = 0
note_counter = 0

frame_beat_counter = 15
frame_beat_counter_total = 15

beat_counter = 0

function pad_score(value, length) {
	while(string_length(string(value)) < length) {
		value = "0" + string(value)
	}
	
	return value
}

credits_to_draw = "Sonic The Hedgehod \"The Caterkiller's Jam\" by Dj-J-Rad Provided by OC Remix"
score_to_draw =""

if !audio_is_playing(snd_testmusic) {
	audio_play_sound(snd_testmusic, 1,0)
	
}