/// @desc 

renderer.exposure = lerp(0, 1, fade_time/max_fade_time)
renderer.Update()

renderer2.exposure = lerp(0, 1, fade_time/max_fade_time)
renderer2.Update()




BulbApplyLightingToSurface(renderer, application_surface)

if (room != rMenu and room != rFindingMatch)
	BulbApplyLightingToSurface(renderer2, application_surface)