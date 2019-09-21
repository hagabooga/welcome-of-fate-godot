extends Node




var current_map : Map

func get_tilemap() -> TileMap:
	return current_map.tilemap_soil



var season_list = ["spring","summer","fall","winter"]
var season = 0
var day = 1
var day_of_week = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
var hour = 6
var minute = 0


var plants = []
var world
var plants_obj
var tilemap_grass
var tilemap_dirt
var tilemap_soil_objects
var tilemap_soil
var tilemap_world_objects

signal next_day
signal time_increased
signal hour_increased

var time_delta = 5
var time = time_delta
var player 

var time_stop = false

func _process(delta):
#	if Input.is_action_just_pressed("ctrl"):
#		next_day()
	#i(time)
	if time_stop:
		return
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
	hour = 6
	minute = 0
	time = 5
	time_stop = true
	emit_signal("next_day")

func is_pos_adjacent(a : Vector2, b : Vector2) -> bool:
	return a == b or \
	(a.x == b.x and (a.y + 1 == b.y or a.y - 1 == b.y)) or \
	(a.y == b.y and (a.x + 1 == b.x or a.x - 1 == b.x)) or \
	(a.x + 1 == b.x and a.y + 1 == b.y) or \
	(a.x - 1 == b.x and a.y - 1 == b.y) or \
	(a.x + 1 == b.x and a.y - 1 == b.y) or \
	(a.x - 1 == b.x and a.y + 1 == b.y)
