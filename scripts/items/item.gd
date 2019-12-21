extends Object

class_name Item

var ming
var desc
var eff_desc
var cost
var type
var act
var base
var placeable

func _init(ming : String, data : Dictionary):
	self.ming = ming
	desc = data.desc
	eff_desc = data.eff_desc if data.has("eff_desc") else ""
	cost = data.cost
	type = data.type
	act = data.activate if data.has("activate") else -1
	placeable = data.placeable if data.has("placeable") else false
	base = data.base if data.has("base") else null