/// @desc 

light.x = x
light.y = y

light2.x = x
light2.y = y

image_index = colorNameToID(color)
light.blend = colorNameToColor(color)
light2.blend = colorNameToColor(color)

light.visible = color != "none"


if (color == MY_PLAYER.color) {
	fade_time++
}
else {
	fade_time--
}

fade_time = clamp(fade_time, 0, max_fade_time)

light2.visible = fade_time > 0
light2.intensity = lerp(0, 1, fade_time/max_fade_time)

//light2.visible = fade_time > 0
//light2.intensity = lerp(0, 1, fade_time/max_fade_time)