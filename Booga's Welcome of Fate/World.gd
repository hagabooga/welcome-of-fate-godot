extends Node2D

var seed_scene = preload("res://plants/Plant.tscn")
var plants = []


func get_player_facing_tile_pos():
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
		if $TileMaps/Soil.get_cell_autotile_coord(get_player_facing_tile_pos().x,(get_player_facing_tile_pos().y)) == Vector2(1,3):
			$TileMaps/SoilObjects.set_cellv(get_player_facing_tile_pos(), 1)
	if Input.is_action_just_pressed("action"):
		for i in range(-1,2):
			for j in range(-1,2):
				var posit = $TileMaps/Soil.world_to_map($Player.global_position)
				var current_tile = Vector2(posit.x+i,posit.y+j)
				if  $TileMaps/Soil.get_cell_autotile_coord(current_tile.x,current_tile.y) == Vector2(1,3) and\
					($TileMaps/SoilObjects.get_cellv(current_tile) == 0 or $TileMaps/SoilObjects.get_cellv(current_tile) == 1):
						var occupied = false;
						for x in plants:
							if (x.tile_pos == current_tile):
								occupied = true
						if !occupied:
							var pos = $TileMaps/Soil.map_to_world(current_tile)
							var new_seed = seed_scene.instance()
							new_seed.set_script(load("res://Turnip.gd"))
							new_seed.global_position = pos
							$Plants.add_child(new_seed)
							new_seed.tile_pos = current_tile
							plants.append(new_seed)
							
	if Input.is_action_just_pressed("ui_cancel"):
		world_globals.emit_next_day()
	if Input.is_action_just_pressed("v"):
		print($Player/HurtArea.get_overlapping_areas())
	

func _on_WarpToInside_body_entered(body):
	body.global_position = $Objects/InsidePlayerHome/WarpPoint.global_position

func _on_WarpToOutsideHome_body_entered(body):
	body.global_position = $Objects/PlayerHome/WarpPoint.global_position
