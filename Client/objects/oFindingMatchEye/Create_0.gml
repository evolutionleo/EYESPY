/// @desc 

color = choose("red", "blue")

dir = choose(45, 135, 225, 315)

light1 = new BulbLight(oLightController.renderer, sEyeLight, 0, x, y)
light2 = new BulbLight(oLightController.renderer2, sEyeLight, 0, x, y)

light1.xscale = image_xscale
light1.yscale = image_yscale

light2.xscale = image_xscale
light2.yscale = image_yscale