extends Sprite

var cycle = [
Color(0.329,0.329,0.459,0.3),
Color(0.298,0.345,0.467,0.25),
Color(0.4,0.431,0.565,0.2),
Color(0.514,0.569,0.722,0.15),
Color(0.6,0.671,0.82,0.12),
Color(0.702,0.812,0.929,0.08),
Color(0.8,0.898,0.973,0.06),
Color(0.902,0.98,0.98,0.03),
Color(1,1,1,0),
Color(0.988,0.996,0.953,0.01),
Color(0.973,0.969,0.902,0.05),
Color(0.925,0.871,0.8,0.06),
Color(0.835,0.725,0.702,0.08),
Color(0.741,0.6,0.682,0.11),
Color(0.62,0.502,0.592,0.2),
Color(0.506,0.4,0.58,0.25),
Color(0.298,0.298,0.467,0.3)
]
var i = 8
var day_night_cycle_times = [1,3,4,5,6,7,9,11,
12,
17,18,19,20,21,22,23,24]

func _ready():
	world_globals.connect("hour_increased", self, "next_color")

func next_color():
	if (world_globals.hour in day_night_cycle_times):
		if i == len(cycle) - 1:
			i = 0
		else:
			i += 1
		get_material().set_shader_param("color", cycle[i])

func _process(delta):
	get_material().set_shader_param("color", cycle[i])