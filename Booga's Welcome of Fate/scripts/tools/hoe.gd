extends "res://scripts/tools/tool.gd"

func _init():
	tool_anim = "rsls"
	$AnimatedSprite.frames = load("res://frames/hoe/hoe_frames.tres")

func use():
	var facing = get_owner().get_facing_tile_pos()
	if world_globals.tilemap_soil.get_cell_autotile_coord(facing.x,\
	(facing.y)) == Vector2(1,3) and world_globals.tilemap_soil_objects.get_cellv(facing) == -1 and \
	!(facing in world_globals.tilemap_world_objects.get_used_cells()):
		world_globals.tilemap_soil_objects.set_cellv(facing, 0)