/// @desc

// a macro set in the config file
if (!DUAL_INSTANCE) {
	instance_destroy()
	exit
}

window_set_fullscreen(false)

var wid = MultiClientGetID()

if (wid == 0) {
    window_set_position(window_get_x() - window_get_width() / 2 + 3200, window_get_y() - 300)
    // <primary instance>
    window_set_caption("P1")
}
if (wid == 1) {
    window_set_position(window_get_x() + window_get_width() / 2 + 3200, window_get_y() - 300)
    // <secondary instance>
    window_set_caption("P2")
	
	// you probably want to add some logic here to disable music, etc.
	onSecondWindow()
}