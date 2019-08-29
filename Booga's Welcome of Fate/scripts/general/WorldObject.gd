extends Clickable

class_name WorldObject

var ming : String

func _on_WorldObject_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print("clicked: ", name)
			emit_signal("clicked")
		elif event.button_index == 2 and event.pressed:
			print("right clicked: ", name)
			emit_signal("right_clicked")
			#print(tile_pos, " ", get_sprite_map_size())

func get_sprite_map_size() -> Vector2:
	if $Sprite.region_enabled:
		return Vector2($Sprite.region_rect.size.x/$Sprite.hframes/32, $Sprite.region_rect.size.y/32/$Sprite.vframes)
	else:
		return Vector2($Sprite.texture.get_width()/32, $Sprite.texture.get_height()/32)