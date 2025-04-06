/// @desc 

fade_time++
if (fade_time >= max_fade_time)
	instance_destroy()

if (hit_me) {
	light.visible = true
	light2.visible = true
}

image_alpha = lerp(1, 0, fade_time/max_fade_time)
light.intensity = image_alpha
light2.intensity = image_alpha