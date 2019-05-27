extends Node

class_name Skill

var ming
var desc
var eff_desc
var rank
var max_rank
var damage
var cooldown
var channel_duration
var mana
var type

func _init(m,d,mx):
	ming = m
	desc = d
	max_rank = mx
	rank = 0
	