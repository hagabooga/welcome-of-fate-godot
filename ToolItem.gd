extends Item

class_name ToolItem

var energy_cost
var hack
var stats

func _init(ming : String, data : Dictionary).(ming, data):
	hack = data.hack if data.has("hack") else false
	energy_cost = data.energy_cost if data.has("energy_cost") else 5
	stats = Attributes.new()
	if data.has("stats"):
		for x in data.stats.keys():
			stats.buff_stat(global_id.stats_nameToid[x], data.stats[x])