/// @desc 

if (keyboard_check_pressed(ord("M")))
	mute = !mute

if mute {
	audio_stop_all()
}