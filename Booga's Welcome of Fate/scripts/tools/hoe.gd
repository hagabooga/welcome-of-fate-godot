extends "res://scripts/tools/tool.gd"

func use():
	var facing = get_player_facing_tile_pos()
	if world_globals.tilemap_soil.get_cell_autotile_coord(facing.x,\
	(facing.y)) == Vector2(1,3) and world_globals.tilemap_soil_objects.get_cellv(facing) == -1 and \
	!(facing in world_globals.tilemap_world_objects.get_used_cells()):
		world_globals.tilemap_soil_objects.set_cellv(facing, 0)