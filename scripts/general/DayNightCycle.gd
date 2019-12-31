extends CanvasModulate

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
var day_night_cycle_times = [1,2,3,4,5,6,8,9,
10,
17,18,19,20,21,22,23,24]
var current_col : Color = cycle[day_night_cycle_times.find(6)]


func _ready():
	world_globals.connect("hour_increased", self, "next_color")
	current_col.a = 1
	set_color(current_col)
	
func next_color():
	if (world_globals.hour in day_night_cycle_times):
		var new_col = cycle[day_night_cycle_times.find(world_globals.hour)]
		new_col.a = 1
		$Tween.interpolate_property(self, "color", current_col, new_col, world_globals.time_delta*3, Tween.TRANS_SINE, Tween.EASE_OUT)
		$Tween.start()
		current_col = new_col