extends "res://tool.gd"

func use():
	if world_globals.tilemap_soil.get_cell_autotile_coord(get_player_facing_tile_pos().x,\
	(get_player_facing_tile_pos().y)) == Vector2(1,3):
		world_globals.tilemap_soil_objects.set_cellv(get_player_facing_tile_pos(), 0)