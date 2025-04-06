/// @description platformer inputs logic


if (dead) {
	fade_time--
	
	if (fade_time <= 0) {
		oLightController.fade_time--
		if (oLightController.fade_time == 0) {
			send({ cmd: "next round ready" })
		}
	}
}

light.visible = true
light.intensity = lerp(0, 1, fade_time/max_fade_time)
light2.intensity = lerp(0, 1, fade_time/max_fade_time)

if (!remote and light == light2) {
	light2 = new BulbLight(oLightController.renderer, sEyeLight, 0, x, y)
	light2.xscale = 1
	light2.yscale = 1
}


if (!remote) {
	with (inputs) {
		kup = keyboard_check(ord("W")) || keyboard_check(vk_up)
		kleft = keyboard_check(ord("A")) || keyboard_check(vk_left)
		kdown = keyboard_check(ord("S")) || keyboard_check(vk_down)
		kright = keyboard_check(ord("D")) || keyboard_check(vk_right)
		
		kshoot = mouse_check_button(mb_left)
		
		move.x = kright - kleft
		move.y = kdown - kup
	}
	
	if (!dead) {// and !oLightController.fade_in) {
		spd.x = inputs.move.x * 5
		spd.y = inputs.move.y * 5
	}
	
	
	#region Collisions
	
	var stepped = false
	
	if (place_meeting(x + spd.x, y, oWall)) {
		for(var dy = -yt; dy <= yt; dy++) {
			if (!place_meeting(x + spd.x, y + dy, oWall)) {
				y += dy
				stepped = true
				break
			}
		}
		
		if (!stepped) {
			while(!place_meeting(x + sign(spd.x), y, oWall)) {
				x += sign(spd.x)
			}
			spd.x = 0
		}
	}
	x += spd.x
	
	
	if (place_meeting(x, y + spd.y, oWall)) {
		if (!stepped) {
			for(var dx = -xt; dx <= xt; dx++) {
				if (!place_meeting(x + dx, y + spd.y, oWall)) {
					x += dx
					stepped = true
					break
				}
			}
		}
		
		if (!stepped) {
			while(!place_meeting(x, y + sign(spd.y), oWall)) {
				y += sign(spd.y)
			}
			spd.y = 0
		}
	}
	y += spd.y
	
	#endregion
	
	
	var tdir = point_direction(x, y, mouse_x, mouse_y)
	dir += angle_difference(real(tdir), real(dir)) * 1
	inputs.dir = dir
	
	//image_angle = inputs.dir
	
	
	sendPlayerControls(inputs)
	
	send({cmd: "player pos", x, y, round: global.round})
	
	
	//var lay_id = layer_get_id("Background")
	//var bg_id = layer_background_get_id(lay_id)
	//layer_background_blend(bg_id, colorNameToColor(color))
}


// update our light
light.x = x
light.y = y
light.angle = dir
light.blend = colorNameToColor(color)

light2.x = x
light2.y = y
light2.angle = dir
light2.blend = colorNameToColor(color)

//if (remote) {
//	light.visible = false
//}


if (state == states.walk) {
	
}