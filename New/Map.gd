extends Node2D

class_name Map


var world_objs = {}
var world_objs_ref = {}
var used_cells = {}#= []
var tilled_soil_objs = []

var last_level : String = ""
var tilemap_grass : TileMap
var tilemap_dirt  : TileMap
var tilemap_soil : TileMap
var tilemap_soilObjects : TileMap
var tilemap_worldObjects : TileMap
var tilemap_waterCliff : TileMap
var player : Player

func _ready():
	call_deferred("setup")
	
func setup():
	ItemHotkeyPreview.set_map(self)
	world_globals.player = find_node("Player")
	world_globals.current_map = self
	world_globals.connect("next_day", self, "create_daily_objects")
	tilemap_grass = $TileMaps/Grass
	tilemap_dirt = $TileMaps/Dirt
	tilemap_soil = $TileMaps/Soil
	tilemap_worldObjects = $TileMaps/WorldObjects
	tilemap_waterCliff = $TileMaps/WaterCliff
	

	if !name in map_data.data:
		connect_scene_world_objects()
		# create objects if first time load
		#connect_click_to_player($Chicken)
		create_tilled_soils()
		create_daily_objects()
		
	else:
		# delete preset scene objects
		for x in $WorldObjects.get_children():
			x.queue_free()
		# LOAD DATA
		var data = map_data.data[name]
		for pos in data:
			var obj := create_world_object(data[pos][0], pos)
			obj.load_data(data[pos][1])
	create_water_source()
	if last_level != "":
		player.global_position = $Warps.find_node(last_level).global_position
	visible = true
		#map_data.add_map_data(self)
	#print(map_data.data)
	#print(used_cells)
	print(used_cells)

func connect_scene_world_objects():
	for x in $WorldObjects.get_children():
		var size : Vector2 = x.get_sprite_map_size()
		var pos = tilemap_grass.world_to_map(x.global_position)
		x.tile_pos = pos
		world_objs[pos] = x.ming
		world_objs_ref[pos] = x
		if len(x.get_signal_connection_list("clicked")) == 0:
			connect_click_to_player(x)
		for row in range(size.x):
			for col in range(size.y):
				pos.x += row
				pos.y += col
				used_cells[pos] = x.ming
				pos = tilemap_grass.world_to_map(x.global_position)
			
			
func connect_click_to_player(x : Clickable) -> void:
	x.connect("clicked", player, "left_click_obj", [x])
	x.connect("right_clicked", player, "right_click_obj", [x])

func _process(delta):
	pass
		
func remove_cell(pos : Vector2):
	#print("erasing: ", pos)
	used_cells.erase(pos)
	world_objs.erase(pos)

func create_world_object(ming : String, pos : Vector2) -> WorldObject:
	var obj = world_objects_database.instance_object(ming)
	$WorldObjects.add_child(obj)
	obj.global_position = tilemap_grass.map_to_world(pos)
	obj.z_index = pos.y - 1
	connect_click_to_player(obj)
	obj.tile_pos = pos
	obj.ming = ming
	var size : Vector2 = obj.get_sprite_map_size()
	for row in range(size.x):
		for col in range(size.y):
			pos.x += row
			pos.y += col
			if ming != "TilledSoil" and ming != "WaterSource":
				used_cells[pos] = obj.ming
			pos = tilemap_grass.world_to_map(obj.global_position)
	
	if ming != "WaterSource": #and ming != "TilledSoil"
		world_objs[pos] = obj.ming
		world_objs_ref[pos] = obj
	if ming == "TilledSoil":
		tilled_soil_objs.append(obj)
	return obj

# tilled soils should be appended to used_cells as it is overlapable
func create_tilled_soils():
	for x in tilemap_soil.get_used_cells():
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3) :
			create_world_object("TilledSoil", x)

func create_water_source():
	for x in tilemap_waterCliff.get_used_cells():
		create_world_object("WaterSource", x)

# Need to make chance table for these objects
func create_daily_objects():
	randomize()
	var names = ["branch", "rock", "weed", "wild berries", "dandelion", "bamboo shoot", "red flower"]
	# Put world objects on grass thats not on dirt or soil
	for x in tilemap_grass.get_used_cells():
		var i = randi()%100
		# Grass - Dirt - Soil - Used
		if !(x in tilemap_dirt.get_used_cells()) \
		and !(x in tilemap_soil.get_used_cells()) and !(x in tilemap_waterCliff.get_used_cells())\
		 and i < 2 and !(x in used_cells):
			var rand_choice = names[randi() % names.size()]
			create_world_object(rand_choice, x)
	# Put world objects on soil (not on edges of soil)
	for x in tilemap_soil.get_used_cells():
		#print(x)
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3):
			var i = randi()%100
			print(!(x in used_cells) and is_tilled_soil_good_has_plant(x))
			if !(x in used_cells) and i < 5 and is_tilled_soil_good_has_plant(x):
				names = ["branch", "rock", "weed"]
				var rand_choice = names[randi() % names.size()]
				create_world_object(rand_choice, x)

func is_tilled_soil_good_has_plant(pos):
	var plants = []
	for x in tilled_soil_objs:
		if pos == x.tile_pos and x.plant == null and !x.find_node("Seed").visible:
			return true
	return false