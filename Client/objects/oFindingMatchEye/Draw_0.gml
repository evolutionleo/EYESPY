/// @desc 

draw_self()

var dx = 0, dy = 0
//draw_sprite_ext(sEyeDamage, colorNameToID(color) * 3 + clamp(max_hp-hp, 0, 2), x + dx, y + dy, image_xscale, image_yscale, dir, c_white, 1.0)
draw_sprite_ext(sEyePupil, colorNameToID(color), x + dx, y + dy, image_xscale, image_yscale, dir, c_white, 1.0)
