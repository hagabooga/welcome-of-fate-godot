extends Clickable

class_name WorldObject

var ming : String

func _on_WorldObject_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print("clicked: ", name, "@", tile_pos)
			emit_signal("clicked")
		elif event.button_index == 2 and event.pressed:
			print("right clicked: ", name, "@", tile_pos)
			emit_signal("right_clicked")
			#print(tile_pos, " ", get_sprite_map_size())

func get_sprite_map_size() -> Vector2:
	if $Sprite.region_enabled:
		return Vector2(int(ceil($Sprite.region_rect.size.x/$Sprite.hframes/float(32))*$Sprite.scale.x), \
		int(ceil($Sprite.region_rect.size.y/float(32)/$Sprite.vframes)*$Sprite.scale.x))
	else:
		return Vector2(int(ceil($Sprite.texture.get_width()/float(32))*$Sprite.scale.x),\
		 int(ceil($Sprite.texture.get_height()/float(32))*$Sprite.scale.x))



func _on_WorldObject_tree_exiting():
	get_parent().get_parent().remove_cell(tile_pos)


func _on_WorldObject_tree_exited():
	pass # Replace with function body.
