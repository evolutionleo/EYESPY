/// @desc

global.canvas = new SUICanvas()

var btn_w = 192
var btn_h = 64
var offset_y = 10

if (global.bottom_text == "")
	global.bottom_text = "Click to find a match"
else {
	global.bottom_text = choose(
		"Eye for an eye!",
		"I'll turn a blind eye",
		"More than meets the eye!",
		"All eyes on you!"
	)
}

txt_title = global.canvas.appendChild(new SUITitle(0, 260, "EYESPY"))
txt_title.set("center", room_width/2)

txt_find = global.canvas.appendChild(new SUITitle(0, room_height-192, SUIBind("global.bottom_text"), {font: fBottomText}))
txt_find.set("center", room_width/2)

findMatch = function() { room_goto(rFindingMatch) }

//btn_mm = global.canvas.appendChild(new SUIButton(0, room_height/2-(btn_h+offset_y)/2, "Find Match", findMatch, {w: btn_w, h: btn_h}))
//btn_lobbies = global.canvas.appendChild(new SUIButton(0, room_height/2+(btn_h+offset_y)/2, "Lobbies", function() { room_goto(rLobbiesList) }, {w: btn_w, h: btn_h}))
//btn_login = global.canvas.appendChild(new SUIButton(0, room_height/2+(btn_h+offset_y)/2+(btn_h+offset_y), "Login", function() { room_goto(rLogin) }, {w: btn_w, h: btn_h}))

//btn_mm.set("center", room_width/2)
//btn_lobbies.set("center", room_width/2)
//btn_login.set("center", room_width/2)


alarm[0] = 30