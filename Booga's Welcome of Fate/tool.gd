extends Node2D

func get_player_facing_tile_pos():
	var pos = world_globals.tilemap_soil.world_to_map(global_position)
	var anim = get_parent().get_node("AnimatedSprite").animation
	if anim == "idle_side" or anim == "walk_side":
		if(get_parent().get_node("AnimatedSprite").flip_h == true):
			pos.x += 1
		else:
			pos.x += -1
	elif anim == "idle_up" or anim == "walk_up":
		pos.y += -1
	elif anim == "idle_down" or anim == "walk_down":
		pos.y += 1
	return pos

func use():
	pass