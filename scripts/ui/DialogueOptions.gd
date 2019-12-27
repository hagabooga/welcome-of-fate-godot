extends ItemList



func _process(delta):
	if (get_parent().visible):
		if ($Timer.time_left <= 0 and visible and Input.is_action_just_pressed("z")):
			for x in get_selected_items():
				emit_signal("item_activated", x)