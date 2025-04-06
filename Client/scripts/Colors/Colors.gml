// <3

#macro C_BLUE_PURE #00AEF0
#macro C_BLUE merge_color(c_black, C_BLUE_PURE, .5)
//#macro C_RED merge_color(c_black, #FF0069, global.merge_amount)
#macro C_RED_PURE #FF0069
#macro C_RED merge_color(c_black, C_RED_PURE, global.merge_amount)

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