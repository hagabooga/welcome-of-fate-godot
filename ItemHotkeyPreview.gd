extends Sprite

var current_map : Map = null 

var item_holder : ItemHolder = null

func _ready():
	for x in get_parent().get_children():
		if x is Map:
			current_map = x
			break

func _process(delta):
	if item_holder != null:
		var item = item_holder.item
		if item != null:
			if item.type == "misc.":
				var pos = current_map.tilemap_soil.world_to_map(get_global_mouse_position())
				global_position = current_map.tilemap_soil.map_to_world(pos)
			else:
				global_position = get_global_mouse_position()
		
func set_item_holder(holder):
	item_holder = holder
	texture = holder.get_texture()
	