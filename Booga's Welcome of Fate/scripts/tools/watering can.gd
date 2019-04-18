extends "res://scripts/tools/tool.gd"

func _init():
	$AnimatedSprite.frames = load("res://watering_can/watering_can_frames.tres")
	$AnimatedSprite.connect("animation_finished",self ,"stop_anim")
	
func use():
	var tile = get_player_facing_tile_pos()
	if world_globals.tilemap_soil_objects.get_cellv(tile) == 0:
		world_globals.tilemap_soil_objects.set_cellv(tile, 1)
	