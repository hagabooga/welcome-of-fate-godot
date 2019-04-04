extends Node2D


func get_player_tile_pos():
	var pos = $TileMaps/Soil.world_to_map($Player.global_position)
	var anim = $Player.get_node("AnimatedSprite").animation
	if anim == "idle_side" or anim == "walk_side":
		if($Player.get_node("AnimatedSprite").flip_h == true):
			pos.x += 1
		else:
			pos.x += -1
	elif anim == "idle_up" or anim == "walk_up":
		pos.y += -1
	elif anim == "idle_down" or anim == "walk_down":
		pos.y += 1
	#print(pos)
	return pos

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		#print($Soil.get_cell_autotile_coord(get_player_tile_pos().x,(get_player_tile_pos().y)))
		if $TileMaps/Soil.get_cell_autotile_coord(get_player_tile_pos().x,(get_player_tile_pos().y)) == Vector2(1,3):
			$TileMaps/SoilObjects.set_cellv(get_player_tile_pos(), 0)
		


func _on_WarpToInside_body_entered(body):
	body.global_position = $Objects/InsidePlayerHome/WarpPoint.global_position

func _on_WarpToOutsideHome_body_entered(body):
	body.global_position = $Objects/PlayerHome/WarpPoint.global_position
