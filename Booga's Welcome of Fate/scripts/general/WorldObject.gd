extends Clickable

class_name WorldObject

var tile_pos : Vector2 setget set_tile_pos



func set_tile_pos(pos : Vector2):
	tile_pos = pos

func clicked(tewl):
	pass

func _on_WorldObject_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("clicked")

