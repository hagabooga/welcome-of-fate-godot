extends Node2D

class_name Map

export(int) var bgm_id


var item_drop = load("res://item/ItemDrop.tscn")

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
var player 


var floating_items = []

#func _process(delta):
#	if Input.is_action_just_pressed("shift"):
#		#print(world_objs)
#		var a = []
#		for x in tilled_soil_objs:
#			a.append(x.tile_pos)
#		print(a)


func generate_item(ming: String, obj: Node2D):
	var x = item_drop.instance()
	var x0 = x.get_child(0)
	var x1 = x.get_child(1)
	for i in floating_items:
		i.add_collision_exception_with(x0)
		i.add_collision_exception_with(x1)
	x.setup_item(ming)
	x.global_position = obj.global_position
	x.add_ignore_other_items(floating_items)
	floating_items.append(x0)
	floating_items.append(x1)
	add_child(x)
func _ready():
	call_deferred("setup")
	
func setup():
	ItemHotkeyPreview.set_map(self)
	player.play_bgm(bgm_id)
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
		# NEED TO ALSO ADD TILLED SOIL OBJECTS
		for x in $WorldObjects.get_children():
			x.queue_free()
#		print("GOING INTO SAVED MAP: ", tilled_soil_objs)
#		create_tilled_soils()
		# delete preset scene objects
		
		# LOAD DATA
		var data = map_data.data[name]
		for pos in data :
			if pos is Vector2:
				var obj = create_world_object(data[pos][0], pos)
				obj.load_data(data[pos][1])
			else:
				for pos in data["TilledSoil"]:
					var obj = create_world_object("TilledSoil", pos)
					obj.load_data(data["TilledSoil"][pos])

	create_water_source()
	
	if last_level != "":
		player.global_position = $Warps.find_node(last_level).global_position
	visible = true
	#print(map_data.data)
	#print(used_cells)

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

func remove_cell(pos : Vector2):
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
	
	if ming != "WaterSource" and ming != "TilledSoil":
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
		 and i < 5 and !(x in used_cells):
			var rand_choice = names[randi() % names.size()]
			create_world_object(rand_choice, x)
	# Put world objects on soil (not on edges of soil)
	for x in tilemap_soil.get_used_cells():
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3):
			var i = randi()%100
			print(!(x in used_cells) and is_tilled_soil_good_has_plant(x))
			if !(x in used_cells) and i < 8 and is_tilled_soil_good_has_plant(x):
				names = ["branch", "rock", "weed"]
				var rand_choice = names[randi() % names.size()]
				create_world_object(rand_choice, x)

func is_tilled_soil_good_has_plant(pos):
	var plants = []
	for x in tilled_soil_objs:
		if pos == x.tile_pos and x.plant == null and !x.find_node("Seed").visible:
			return true
	return false
