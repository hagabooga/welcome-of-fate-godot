extends Node2D

class_name Map

var used_cells = []

var tilemap_grass : TileMap
var tilemap_dirt  : TileMap
var tilemap_soil : TileMap
var tilemap_soilObjects : TileMap
var tilemap_worldObjects : TileMap
var player : Player

func _ready():
	world_globals.current_map = self
	tilemap_grass = $TileMaps/Grass
	tilemap_dirt = $TileMaps/Dirt
	tilemap_soil = $TileMaps/Soil
	tilemap_worldObjects = $TileMaps/WorldObjects
	create_world_objects()
	
func _process(delta):
	pass
	#for x in $TileMaps.get_children():
		#x.global_position = Vector2.ZERO
		

func create_world_object(ming : String, pos : Vector2):
	var obj = world_objects_database.instance_object(ming)
	$WorldObjects.add_child(obj)
	obj.global_position = tilemap_grass.map_to_world(pos)
	obj.z_index = pos.y - 1
	obj.connect("clicked", player, "click_obj", [obj])
	obj.tile_pos = pos
	used_cells.append(obj.tile_pos)
	#world_objects.append(obj)
	#print(world_objects)

func create_world_objects():
	for x in $WorldObjects.get_children():
		var size : Vector2 = x.get_sprite_map_size()
		var pos = tilemap_grass.world_to_map(x.global_position)
		x.tile_pos = pos
		x.connect("clicked", player, "click_obj", [x])
		for row in range(size.x):
			for col in range(size.y):
				pos.x += row
				pos.y += col
				used_cells.append(pos)
				pos = tilemap_grass.world_to_map(x.global_position)
	#print(used_cells)
	randomize()
	var names = ["branch", "rock"]
	# Put world objects on grass thats not on dirt or soil
	for x in tilemap_grass.get_used_cells():
		var i = randi()%100
		if !(x in tilemap_dirt.get_used_cells()) and !(x in tilemap_soil.get_used_cells()) and i < 10 and !(x in used_cells):
			create_world_object(names[randi() % names.size()], x)
	# Put world objects on soil (not on edges of soil)
	for x in tilemap_soil.get_used_cells():
		var i = randi()%100
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3) :
			create_world_object("TilledSoil", x)
			if !(x in tilemap_worldObjects.get_used_cells()) and i < 60:
				create_world_object(names[randi() % names.size()], x)
	#print(used_cells)