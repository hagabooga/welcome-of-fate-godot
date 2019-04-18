extends "res://scripts/tools/tool.gd"

var seed_scene = preload("res://plants/Plant.tscn")
var plant_ming

func use():
	var tile_soilobj = world_globals.tilemap_soil_objects
	for i in range(-1,2):
		for j in range(-1,2):
			var posit = world_globals.tilemap_soil.world_to_map(global_position)
			var current_tile = Vector2(posit.x+i,posit.y+j)
			if (tile_soilobj.get_cellv(current_tile) == 0 or tile_soilobj.get_cellv(current_tile) == 1):
				#$TileMaps/Soil.get_cell_autotile_coord(current_tile.x,current_tile.y) == Vector2(1,3) and\
				var occupied = false;
				for x in world_globals.plants_obj.get_children():
					if (x.tile_pos == current_tile):
						occupied = true
				if !occupied:
					var new_seed = seed_scene.instance()
					new_seed.set_script(load("res://%s.gd"%plant_ming))
					new_seed.global_position = world_globals.tilemap_soil.map_to_world(current_tile)
					new_seed.tile_pos = current_tile
					world_globals.plants_obj.add_child(new_seed)
