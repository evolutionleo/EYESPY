/// @desc 

draw_set_font(fScore)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_color(C_RED_PURE)
draw_text(room_width/2-120, room_height/2, global.score.red ?? 0)

draw_set_color(c_white)
draw_text(room_width/2, room_height/2, "-")

draw_set_color(C_BLUE_PURE)
draw_text(room_width/2+120, room_height/2, global.score.blue ?? 0)