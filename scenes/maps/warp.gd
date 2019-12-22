extends Area2D


export(String) var map

var once = false

func _on_ToWormDesert_body_entered(body):
	
	if body is Player and not once:
		once = true
		var root = get_tree().root
		#print(get_tree().get_current_scene().name)
		var player = get_tree().get_current_scene().player
		get_tree().get_current_scene().remove_child(player)
		var level = get_tree().get_current_scene()
		var level_name = level.name
		level.call_deferred("free")
		var next_level : Map = load("res://scenes/maps/%s.tscn"%map).instance()
		next_level.last_level = level_name
		#get_tree().get_root().remove_child(player)
		root.call_deferred("add_child", (next_level))
		next_level.player = player
		next_level.call_deferred("add_child", player)
		#player.global_position = next_level.find_node("Warps").find_node(level_name).global_position
#		player.call_deferred("set", "global_position", \
#		next_level.find_node("Warps").find_node(level_name).global_position)
		#next_level.find_node("Warps").find_node(level_name).call_deferred("get", "global_position"))
		get_tree().call_deferred("set_current_scene",(next_level))
		#get_tree().change_scene("res://scenes/maps/worm desert.tscn")
		#get_tree().get_root().remove_child(player)