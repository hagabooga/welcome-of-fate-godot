extends Node2D

var energy_cost = 0

	
func get_player_facing_tile_pos():
	var pos = world_globals.tilemap_soil.world_to_map(global_position)
	var facing = get_parent().facing
	if facing == "side":
		if(get_parent().get_node("AnimatedSprite").flip_h == true):
			pos.x += 1
		else:
			pos.x += -1
	elif facing == "up":
		pos.y += -1
	elif facing == "down":
		pos.y += 1
	return pos

func use():
	pass
	
					
func stop_anim():
	$AnimatedSprite.play("default")