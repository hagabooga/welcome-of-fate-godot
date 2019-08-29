extends Node

class_name BaseStat

var base
var final_val setget ,get_final_value
var bonuses
var type

func _init(t):
	base = 0
	bonuses = []
	type = t

func buff(value):
	bonuses.append(value)

func remove_buff(value):
	bonuses.erase(value)
	
func get_final_value():
	var final = base
	for x in bonuses:
		final += x
	return final