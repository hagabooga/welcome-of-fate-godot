extends Clickable


func right_clicked():
	print("picked up chicken")

func get_sprite_map_size() -> Vector2:
	return Vector2.ONE

func _process(delta):
	change_z_index_relative_to_tilemap()
	tile_pos = owner.tilemap_soil.world_to_map(global_position)

func _on_Chicken_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print("clicked: ", name, "@", tile_pos)
			emit_signal("clicked")
		elif event.button_index == 2 and event.pressed:
			print("right clicked: ", name, "@", tile_pos)
			emit_signal("right_clicked")

func change_z_index_relative_to_tilemap() -> void:
	var z = owner.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = owner.tilemap_soil.world_to_map(global_position).y
