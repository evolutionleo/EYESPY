
draw_self()

draw_set_halign(fa_center)

// draw a tiny arrow above us
//if (!remote)
//draw_text((bbox_right + bbox_left) / 2, bbox_top - 20, self.name)
//draw_text((bbox_right + bbox_left) / 2, bbox_top - 20, $"{hp}/{max_hp}")

var dx = 0, dy = 0
draw_sprite_ext(sEyeDamage, colorNameToID(color) * 3 + clamp(max_hp-hp, 0, 2), x + dx, y + dy, image_xscale, image_yscale, dir, c_white, 1.0)
draw_sprite_ext(sEyePupil, colorNameToID(color), x + dx, y + dy, image_xscale, image_yscale, dir, c_white, 1.0)
