extends Node2D

class_name Map

var used_cells = []
var tilled_soil_objs = []


var tilemap_grass : TileMap
var tilemap_dirt  : TileMap
var tilemap_soil : TileMap
var tilemap_soilObjects : TileMap
var tilemap_worldObjects : TileMap
var player : Player

func _ready():
	world_globals.player = find_node("Player")
	world_globals.current_map = self
	world_globals.connect("next_day", self, "create_daily_objects")
	tilemap_grass = $TileMaps/Grass
	tilemap_dirt = $TileMaps/Dirt
	tilemap_soil = $TileMaps/Soil
	tilemap_worldObjects = $TileMaps/WorldObjects
	for x in $WorldObjects.get_children():
		var size : Vector2 = x.get_sprite_map_size()
		var pos = tilemap_grass.world_to_map(x.global_position)
		x.tile_pos = pos
		if len(x.get_signal_connection_list("clicked")) == 0:
			x.connect("clicked", player, "left_click_obj", [x])
			x.connect("right_clicked", player, "right_click_obj", [x])
		for row in range(size.x):
			for col in range(size.y):
				pos.x += row
				pos.y += col
				used_cells.append(pos)
				pos = tilemap_grass.world_to_map(x.global_position)
	create_tilled_soils()
	create_daily_objects()
	
			
func _process(delta):
	pass
		
func remove_cell(pos : Vector2):
	print("erasing: ", pos)
	used_cells.erase(pos)

func create_world_object(ming : String, pos : Vector2):
	var obj = world_objects_database.instance_object(ming)
	$WorldObjects.add_child(obj)
	obj.global_position = tilemap_grass.map_to_world(pos)
	obj.z_index = pos.y - 1
	obj.connect("clicked", player, "left_click_obj", [obj])
	obj.connect("right_clicked", player, "right_click_obj", [obj])
	obj.tile_pos = pos
	var size : Vector2 = obj.get_sprite_map_size()
	for row in range(size.x):
			for col in range(size.y):
				pos.x += row
				pos.y += col
				pos = tilemap_grass.world_to_map(obj.global_position)
	if ming != "TilledSoil":
		used_cells.append(obj.tile_pos)
	else:
		tilled_soil_objs.append(obj)
	
	#else:
		#print(ming)
	return obj

# tilled soils should be appended to used_cells as it is overlapable
func create_tilled_soils():
	for x in tilemap_soil.get_used_cells():
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3) :
			create_world_object("TilledSoil", x)



func create_daily_objects():
	randomize()
	var names = ["branch", "rock", "weed"]
	# Put world objects on grass thats not on dirt or soil
	for x in tilemap_grass.get_used_cells():
		var i = randi()%100
		# Grass - Dirt - Soil - Used
		if !(x in tilemap_dirt.get_used_cells()) and !(x in tilemap_soil.get_used_cells()) and i < 17 and !(x in used_cells):
			var rand_choice = names[randi() % names.size()]
			create_world_object(rand_choice, x)
	# Put world objects on soil (not on edges of soil)
	for x in tilemap_soil.get_used_cells():
		#print("show")
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3):
			var i = randi()%100
			if !(x in used_cells) and i < 15 and is_tilled_soil_good_has_plant(x):
				var rand_choice = names[randi() % names.size()]
				create_world_object(rand_choice, x)

func is_tilled_soil_good_has_plant(pos):
	var plants = []
	for x in tilled_soil_objs:
		if pos == x.tile_pos and x.plant == null and x.find_node("Seed").visible == false:
			return true
	return false