extends Node

var month = 1
var day = 1
var plants = []
var plants_obj
var tilemap_grass
var tilemap_dirt
var tilemap_soil_objects
var tilemap_soil
var tilemap_world_objects
var dict_world_object_name = {0: "Branch", 1: "Rock", 2: "Weed"}

signal next_day

func next_day():
	if day == 31:
		day = 0
		month += 1
	day += 1
	emit_signal("next_day")
	
func create_world_objects():
	randomize()
	var dirt_tiles = tilemap_dirt.get_used_cells()
	var grass_tiles = tilemap_grass.get_used_cells()
	var soil_tiles = tilemap_soil.get_used_cells()
	for x in grass_tiles:
		var i = randi()%20
		if !(x in dirt_tiles) and 0 == i:
			tilemap_world_objects.set_cellv(x,randi()%2)
	for x in soil_tiles:
		var i = randi()%20
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3):
			if i == 0:
				tilemap_world_objects.set_cellv(x,randi()%2)
			elif !(x in tilemap_world_objects.get_used_cells()) and 1 <= i and i <= 8:
				tilemap_world_objects.set_cellv(x,2)
