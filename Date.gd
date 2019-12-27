extends Panel


func _ready():
	world_globals.connect("time_increased", self, "update_date")
	world_globals.connect("next_day", self, "update_date")
	update_date()
	

func update_date():
	$VBoxContainer/Date.text = world_globals.get_current_season().capitalize() + " " + str(world_globals.day)
	$VBoxContainer/Date2.text = world_globals.get_current_day_of_week().capitalize()
	$VBoxContainer/Time.text = world_globals.get_time_as_string()
	

func unfreeze_time():
	world_globals.time_stop = false