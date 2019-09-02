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

enum  {BASE_MISC, BASE_TOOL, BASE_CONSUMABLE, BASE_WEAPON, BASE_ARMOR}



enum {consume, equip}

func _init(m, d, ef, c, t, a, p):
	ming = m
	desc = d
	eff_desc = ef
	cost = c
	type = t
	act = a
	placeable = p
	base = null
	
func activate():
	if act == consume:
		item_activations.activate(ming)
		player_equip.remove_item_count(self)
	elif act ==	equip:
		player_equip.equip(self)
		
