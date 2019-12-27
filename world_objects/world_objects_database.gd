extends Node

var world_objects_database = {}


func _ready():
	dir_contents("res://world_objects/objects")
	#print(world_objects_database)

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				("Found directory: " + file_name)
			else:
				if file_name.substr(len(file_name) - 5, len(file_name)) == ".tscn":
					var key = file_name.substr(0, len(file_name) - 5)
					world_objects_database[key] = load("res://world_objects/objects/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	#print(world_objects_database)

func instance_object(mingz):
	return world_objects_database[mingz].instance()