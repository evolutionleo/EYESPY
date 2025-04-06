/// @desc 

event_inherited()

//light = new BulbLight(oLightController.renderer2, sTorchLight, 0, x, y)
light = new BulbLight(oLightController.renderer2, sRadialLight, 0, x, y)
light.xscale = 1.5
light.yscale = 1.5
light.visible = false

light2 = new BulbLight(oLightController.renderer, sRadialLight, 0, x, y)
//light2 = new BulbLight(oLightController.renderer, sTorchLight, 0, x, y)
light2.xscale = 1.5
light2.yscale = 1.5
light.visible = false


fade_time = 0
max_fade_time = 60