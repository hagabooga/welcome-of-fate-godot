extends Sprite

class_name Plant

var days_past = 0
var current_stage = -1
var stages = []
var death = 0

var death_counter = 0
var start_counting_death = false
var dead = false

var ming : String

func set_plant(ming, stages, d):
	self.ming = ming
	self.stages = stages
	self.death = d
	texture = load("res://sprites/plants/%s.png"%ming)
	region_rect.size = Vector2(texture.get_width(),  texture.get_height())

func grow_one_day():
	if dead:
		return
	days_past += 1
	for x in range(len(stages)):
		if stages[x] == days_past:
			visible = true
			current_stage = x
			frame = current_stage
			return

func no_water():
	if dead:
		return
	if current_stage != -1:
		death_counter += 1
	print(death_counter)
	if death_counter >= death: 
		frame = vframes*hframes - 1
		dead = true

func has_grown() -> bool:
	return current_stage != -1