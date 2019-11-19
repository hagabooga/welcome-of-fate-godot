extends Sprite

class_name Plant

var days_past = 0
var current_stage = -1
var stages = []

var ming : String

func grow_one_day():
	days_past += 1
	for x in range(len(stages)):
		if stages[x] == days_past:
			visible = true
			current_stage = x
			frame = current_stage
			return

func has_grown() -> bool:
	return current_stage != -1