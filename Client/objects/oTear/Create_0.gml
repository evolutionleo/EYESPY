/// @desc 

event_inherited()

if !oSound.mute
	audio_play_sound_at(aTearShoot, x, y, 0, 300, 100, 1, false, 1)
//audio_play_sound(aTearShoot, 0, false)

layer = layer_get_id("Tears")

//light = new BulbLight(oLightController.renderer2, sTearLight, 0, x, y)
light = new BulbLight(oLightController.renderer2, sRadialLight, 0, x, y)
light.visible = false
light.xscale = 1
light.yscale = 1

//light2 = new BulbLight(oLightController.renderer, sTearLight, 0, x, y)
light2 = new BulbLight(oLightController.renderer, sRadialLight, 0, x, y)
light2.visible = false
light2.xscale = 1
light2.yscale = 1