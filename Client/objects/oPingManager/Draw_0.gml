/// @desc Draw ping

draw_set_halign(fa_right)
draw_set_valign(fa_top)
draw_set_font(fPing)
//if (room == rMenu)
	draw_text(room_width - 20, 25, "ping: " + string(global.ping) + "ms")