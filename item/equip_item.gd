extends Item

class_name EquipItem

var stats
var energy_cost

func _init(data : Dictionary).(data):
	stats = Attributes.new()
	if stats.has("stats"):
		for x in data.stats.keys():
			stats.buff_stat(global_id.stats_nameToid[x], data.stats[x])
	energy_cost = 5