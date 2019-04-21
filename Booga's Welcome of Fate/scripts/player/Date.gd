extends Panel

func _ready():
	world_globals.connect("time_increased", self, "update_labels")
	update_labels()
	
func update_labels():
	$Date.text = "%s %d"%[world_globals.get_current_season().capitalize(),world_globals.day] 
	$Time.text = world_globals.get_time_as_string()