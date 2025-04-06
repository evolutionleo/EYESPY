// <3

#macro C_BLUE merge_color(c_black, #00AEF0, .5)
//#macro C_RED merge_color(c_black, #FF0069, global.merge_amount)
#macro C_RED merge_color(c_black, #FF0069, global.merge_amount)

function colorNameToColor(color_name) {
	//return c_white;
	if (color_name == MY_PLAYER.color)
		return c_gray
	//else
	//	return C_RED
	
	switch(color_name) {
		case "none": return c_gray // c_white
		case "red": return C_RED
		case "blue": return C_BLUE
	}
}

function colorNameToID(color_name) {
	switch(color_name) {
		case "none": return -1
		case "red": return 0
		case "blue": return 1
	}
}