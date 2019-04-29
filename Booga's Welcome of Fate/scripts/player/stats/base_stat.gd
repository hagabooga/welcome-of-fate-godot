extends Node

class_name BaseStat

var value setget ,get_final_value
var bonuses
var type

func _init(t):
	value = 0
	bonuses = []
	type = t

func buff(value):
	bonuses.append(value)

func remove_buff(value):
	bonuses.erase(value)
	
func get_final_value():
	var final = value
	for x in bonuses:
		final += x
	return final