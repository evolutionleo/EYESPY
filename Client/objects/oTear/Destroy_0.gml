/// @desc 

//light.x = xprevious
//light.y = yprevious
var remnant = instance_create_layer(x, y, layer, oTearRemnant, {light: light, light2: light2})
remnant.sprite_index = sprite_index
remnant.image_index = image_index
remnant.image_angle = image_angle
remnant.image_xscale = image_xscale
remnant.image_yscale = image_yscale
remnant.tear_uuid = uuid
remnant.hit_me = hit_me