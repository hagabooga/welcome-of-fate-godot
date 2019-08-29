extends Item

class_name EquipItem

var stats

func _init(m, d, ef, c, b, t, a, col, s).(m, d, ef, c, t, a, col):
	stats = Attributes.new()
	for x in s.keys():
		stats.buff_stat(global_id.stats_nameToid[x], s[x])
	base = b