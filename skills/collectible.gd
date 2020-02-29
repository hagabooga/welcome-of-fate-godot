extends Node

class_name Collectible

var ming : String
var desc : String setget ,get_desc
var rank : int = 0
var points : int = 0
var points_goal : int
var points_multiplier : int
var eff_multiplier : int

func _init(m: String, d: String, pg: int, pm: int, em: int):
	self.ming = m
	self.desc = d
	self.points_goal = pg
	self.points_multiplier = pm
	self.eff_multiplier = em
	
	
func get_desc() -> String:
	return desc%[rank]

func add_point(v : int = 1):
	points += v
	if points == points_goal * points_multiplier * (rank + 1):
		print("Rank Up!")
		rank += 1
	print(get_desc())
