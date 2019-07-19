extends Node2D

class_name Map

var tilemap_grass
var tilemap_dirt
var tilemap_soil
var tilemap_soilObjects
var tilemap_worldObjects


func _ready():
	world_globals.current_map = self
	tilemap_grass = $TileMaps/Grass
	tilemap_dirt = $TileMaps/Dirt
	tilemap_soil = $TileMaps/Soil
	tilemap_soilObjects = $TileMaps/SoilObjects
	tilemap_worldObjects = $TileMaps/WorldObjects
	create_world_objects()
	
func _process(delta):
	pass
	#for x in $TileMaps.get_children():
		#x.global_position = Vector2.ZERO
		

func create_world_objects():
	randomize()
	# Put world objects on grass thats not on dirt or soil
	for x in tilemap_grass.get_used_cells():
		var i = randi()%20
		if !(x in tilemap_dirt.get_used_cells()) and !(x in tilemap_soil.get_used_cells()) and 0 == i:
			tilemap_worldObjects.set_cellv(x,randi()%2)
	# Put world objects on soil (not on edges of soil)
	for x in tilemap_soil.get_used_cells():
		var i = randi()%20
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3):
			if i == 0:
				tilemap_worldObjects.set_cellv(x,randi()%2)
			elif !(x in tilemap_worldObjects.get_used_cells()) and 1 <= i and i <= 8:
				tilemap_worldObjects.set_cellv(x,2)