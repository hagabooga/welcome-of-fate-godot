extends Node

class_name Item

var ming
var desc
var eff_desc
var cost
var type
var act
var color
enum {consume, equip}

func _init(m, d, ef, c, t, a, col):
	ming = m
	desc = d
	eff_desc = ef
	cost = c
	type = t
	act = a
	color = col
	
func activate():
	if act == consume: 
		item_activations.activate(ming) 
	elif act ==	equip:
		player_equip.equip(self)