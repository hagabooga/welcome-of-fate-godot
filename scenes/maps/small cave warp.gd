extends "res://scenes/maps/warp.gd"


func load_stuff():
	once = true
	var root = get_tree().root
	var player = get_tree().get_current_scene().player
	
	get_tree().get_current_scene().remove_child(player)
	var level = get_tree().get_current_scene()
	map_data.add_map_data(level)
	#print(map_data.data)
	var level_name = level.name
	level.call_deferred("free")
	var next_level = load("res://scenes/maps/%s.tscn"%map)
	next_level = next_level.instance()
	next_level.visible = false
	next_level.last_level = level_name
	root.call_deferred("add_child", (next_level))
	next_level.player = player
	player.find_node("Camera2D").find_node("LevelUpAnimation").visible = false
	next_level.cave_level += 1
	next_level.call_deferred("add_child", player)
	get_tree().call_deferred("set_current_scene",next_level)
