/// @desc 

event_inherited()


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