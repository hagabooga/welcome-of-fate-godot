extends Item

class_name ToolItem

var energy_cost
var hack
func _init(ming : String, data : Dictionary).(ming, data):
	hack = data.hack if data.has("hack") else false
	energy_cost = data.energy_cost if data.has("energy_cost") else 5