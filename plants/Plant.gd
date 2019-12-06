extends Sprite

class_name Plant

var days_past = 0
var current_stage = -1
var stages = []
var death = 0

var death_counter = 0
var start_counting_death = false
var dead = false
var multi = false

var ming : String

func set_plant(m, plant_data):
	self.ming = m
	self.stages = plant_data.stages
	self.death = plant_data.death
	if plant_data.has("multi"):
		self.multi = plant_data.multi
	texture = load("res://sprites/plants/%s.png"%ming)
	region_rect.size = Vector2(texture.get_width(),  texture.get_height())
	vframes = texture.get_height()/32

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
			
func go_second_last_stage():
	current_stage = stages[-3]
	frame = current_stage
	days_past = current_stage

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