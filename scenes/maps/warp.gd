extends Area2D

export(bool) var instant
export(String) var map

var once = false


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
	var next_level : Map = load("res://scenes/maps/%s.tscn"%map).instance()
	next_level.visible = false
	next_level.last_level = level_name
	root.call_deferred("add_child", (next_level))
	next_level.player = player
	next_level.call_deferred("add_child", player)
	get_tree().call_deferred("set_current_scene",next_level)


func _on_ToWormDesert_body_entered(body):
	if body is Player and not once:
		if instant:
			load_stuff()
		else:
			body.play_all_idle("")
			body.fade_in(5)
			body.connect("on_full_fade_in", self, "load_stuff")
