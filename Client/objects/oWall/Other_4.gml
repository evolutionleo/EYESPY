/// @desc 

if (room != rMenu)
	event_inherited()

occluder = new BulbStaticOccluder(oLightController.renderer)

occluder.x = x
occluder.y = y

occluder.AddEdge(bbox_left  - x, bbox_top    - y, bbox_right - x+1, bbox_top    - y)
occluder.AddEdge(bbox_right - x+1, bbox_top    - y, bbox_right - x+1, bbox_bottom - y+1)
occluder.AddEdge(bbox_right - x+1, bbox_bottom - y+1, bbox_left  - x, bbox_bottom - y+1)
occluder.AddEdge(bbox_left  - x, bbox_bottom - y+1, bbox_left  - x, bbox_top    - y)


occluder2 = new BulbStaticOccluder(oLightController.renderer2)

occluder2.x = x
occluder2.y = y

occluder2.AddEdge(bbox_left  - x, bbox_top    - y, bbox_right - x+1, bbox_top    - y)
occluder2.AddEdge(bbox_right - x+1, bbox_top    - y, bbox_right - x+1, bbox_bottom - y+1)
occluder2.AddEdge(bbox_right - x+1, bbox_bottom - y+1, bbox_left  - x, bbox_bottom - y+1)
occluder2.AddEdge(bbox_left  - x, bbox_bottom - y+1, bbox_left  - x, bbox_top    - y)