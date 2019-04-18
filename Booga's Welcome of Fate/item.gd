extends Node

class_name Item

var ming
var desc
var eff_desc
var cost
var type
var act
enum {consume, equip}

func _init(m, d, ef, c, t, a):
	ming = m
	desc = d
	eff_desc = ef
	cost = c
	type = t
	act = a
	
func activate():
	if act == consume: 
		item_activations.activate(ming) 
	elif act ==	equip:
		player_equip.equip(self)