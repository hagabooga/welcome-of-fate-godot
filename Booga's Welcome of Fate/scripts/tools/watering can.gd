extends "res://scripts/tools/tool.gd"

func _init():
	$AnimatedSprite.frames = load("res://frames/watering can/watering can_frames.tres")

	
func use():
	var tile = get_owner().get_facing_tile_pos()
	if world_globals.tilemap_soil_objects.get_cellv(tile) == 0:
		world_globals.tilemap_soil_objects.set_cellv(tile, 1)
	