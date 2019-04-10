extends Node

var month = 1
var day = 1
var plants = []
var plants_obj
var tilemap_soil_objects
var tilemap_soil

signal next_day

func next_day():
	day += 1
	emit_signal("next_day")