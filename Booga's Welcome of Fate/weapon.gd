extends Item

class_name Weapon

var stats

func _init(m, d, ef, c, t, a, col, s).(m, d, ef, c, t, a, col):
	stats = Attributes.new()
	stats.magical = s.magical
	#print(stats)