extends Node

var season_list = ["spring","summer","fall","winter"]
var season = 0
var day = 1
var day_of_week = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
var hour = 12
var minute = 0


var plants = []
var world
var plants_obj
var tilemap_grass
var tilemap_dirt
var tilemap_soil_objects
var tilemap_soil
var tilemap_world_objects
var dict_world_object_name = {0: "branch", 1: "rock", 2: "weed"}

signal next_day
signal time_increased
signal hour_increased

var time_delta = 5
var time = time_delta
var player



func _process(delta):
	time -= delta
	if time <= 0:
		time = time_delta
		minute += 10
		if minute % 60 == 0:
			minute = 0
			hour += 1
			emit_signal("hour_increased")
			if hour%24 == 0:
				day += 1
				hour = 0
		emit_signal("time_increased")

func get_time_as_string():
	var hour_string = str(hour)
	var minute_string = str(minute)
#	if hour <= 9:
#		hour_string = "0%d"%hour
	if minute == 0:
		minute_string = "0%d"%minute
	return "%s:%s"%[hour_string,minute_string]

func get_current_season():
	return season_list[season]

func get_current_day_of_week():
	return day_of_week[(day-1)%7]

func next_day():
	if day == 31:
		day = 0
		season += 1
	day += 1
	emit_signal("next_day")
	
func create_world_objects():
	randomize()
	var dirt_tiles = tilemap_dirt.get_used_cells()
	var grass_tiles = tilemap_grass.get_used_cells()
	var soil_tiles = tilemap_soil.get_used_cells()
	for x in grass_tiles:
		var i = randi()%20
		if !(x in dirt_tiles) and !(x in soil_tiles) and 0 == i:
			tilemap_world_objects.set_cellv(x,randi()%2)
	for x in soil_tiles:
		var i = randi()%20
		if tilemap_soil.get_cell_autotile_coord(x.x,x.y) == Vector2(1,3):
			if i == 0:
				tilemap_world_objects.set_cellv(x,randi()%2)
			elif !(x in tilemap_world_objects.get_used_cells()) and 1 <= i and i <= 8:
				tilemap_world_objects.set_cellv(x,2)
