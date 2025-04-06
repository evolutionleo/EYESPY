///// @desc

draw_set_font(fPing)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)

//Name: {global.username}\n
draw_text(20, 25, $"online: {global.online_count}")

//var _y = room_height/2-100
//draw_text(20, _y, "Party:")
//_y += 50

//if (global.party) {
//	for(var i  = 0; i < array_length(global.party.members); i++) {
//		var name = global.party.members[i]
//		draw_set_color(c_white)
//		if (name == global.party.leader)
//			draw_set_color(c_yellow)
	
//		draw_text(30, _y, $"{i+1}) {name}")
//		_y += 30
//	}
//}



//draw_set_halign(fa_center)
//draw_set_color(c_white)