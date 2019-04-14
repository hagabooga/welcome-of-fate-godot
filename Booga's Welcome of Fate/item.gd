extends StaticBody2D

var ming
var desc
var eff_desc
var cost
var type
var activate
enum {consume, equip}

func _init(m, d, ef, c, t, a):
	ming = m
	desc = d
	eff_desc = ef
	cost = c
	type = t
	activate = a
	
func activate():
	if activate == consume:
		item_activations.activate(ming)