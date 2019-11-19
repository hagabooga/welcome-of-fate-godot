extends Node

class_name Item

var ming
var desc
var eff_desc
var cost
var type
var act
var color
var base
var placeable
var energy_cost

enum {consume, equip}

func _init(m, d, ef, c, t, a, p, e=5):
	ming = m
	desc = d
	eff_desc = ef
	cost = c
	type = t
	act = a
	placeable = p
	base = null
	energy_cost = e
	
func activate():
	if act == consume:
		item_activations.activate(ming)
		player_equip.remove_item_count(self)
	elif act ==	equip:
		player_equip.equip(self)
		
