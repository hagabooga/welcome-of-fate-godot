extends Area2D


export(PackedScene) var map

func _on_ToWormDesert_body_entered(body):
	if body is Player:
		var player = get_tree().get_current_scene().find_node("Player")
		get_tree().get_current_scene().remove_child(player)
		
		get_tree().get_root().add_child(player)
		
		get_tree().change_scene("res://scenes/maps/worm desert.tscn")
		get_tree().get_current_scene().add_child(player)