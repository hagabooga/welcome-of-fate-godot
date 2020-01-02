extends Sprite

var current_map : Map = null 

var item_holder : ItemHolderBase = null

func set_map(map : Map):
	current_map = map

func _process(delta):
	if item_holder != null:
		var item = item_holder.item
		if item != null:
			var pos = current_map.tilemap_soil.world_to_map(get_global_mouse_position())
			global_position = current_map.tilemap_soil.map_to_world(pos)


func set_item_holder(holder):
	item_holder = holder
	texture = holder.get_texture()
	