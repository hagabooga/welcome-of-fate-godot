extends Clickable

class_name WorldObject



func clicked(tewl : Tool):
	pass

func _on_WorldObject_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("clicked")
			#print(tile_pos, " ", get_sprite_map_size())

func get_sprite_map_size() -> Vector2:
	if $Sprite.region_enabled:
		return Vector2($Sprite.region_rect.size.x/$Sprite.hframes/32, $Sprite.region_rect.size.y/32/$Sprite.vframes)
	else:
		return Vector2($Sprite.texture.get_width()/32, $Sprite.texture.get_height()/32)