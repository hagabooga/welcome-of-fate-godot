extends Map


func create_daily_objects():
	var occupied_cells = tilemap_soil.get_used_cells() + $TileMaps/Rocks.get_used_cells()
	for x in tilemap_dirt.get_used_cells():
		if not x in occupied_cells and randi()%10 == 0:
			create_world_object("ore", x)
