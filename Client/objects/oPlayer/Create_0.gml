/// @description initialize some constants

// Inherit the parent event
event_inherited()

x = global.start_pos.x
y = global.start_pos.y

wasdead = false

//trace(global.start_pos.x)
//trace(global.start_pos.y)

__interpolation.dir = INTERP.LINEAR

yt = 8
xt = 8

max_fade_time = 60
fade_time = max_fade_time


tearhit_handler = addHandler("tear hit", function(data) {
	if (dead) return;
	
	var p_uuid = data.player
	var tear_uuid = data.uuid
	
	if (self.uuid == p_uuid) {
		if (hp > 1)
			if !oSound.mute audio_play_sound_at(aHit, x, y, 0, 300, 100, 1, false, 1)
			//audio_play_sound(aHit, 0, false)
		
		with(oTearRemnant) {
			if (self.tear_uuid == tear_uuid) {
				hit_me = true
			}
		}
		
		with(oTear) {
			if (self.uuid == tear_uuid) {
				hit_me = true
			}
		}
	}
})


layer = layer_get_id("Players")

light = new BulbLight(oLightController.renderer2, sEyeLight, 0, x, y)
light.xscale = 1
light.yscale = 1
light.visible = false

light2 = light


use_states({ idle: 0, walk: 1 })

function defaultInputs() {
	// controls
	inputs = {
		kright	: false,
		kleft	: false,
		kup		: false,
		kdown	: false,
	
		kshoot  : false,
	
		move: {
			x: 0,
			y: 0
		},
	
		dir: 0
	}
}

defaultInputs()

dir = 0