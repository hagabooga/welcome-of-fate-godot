extends Node

var plant_database
var plant_scene = preload("res://plants/Plant.tscn")

func _ready():
	var file = File.new()
	file.open("res://plants.json", file.READ)
	plant_database = parse_json(file.get_as_text())
	file.close()
	
func make_plant(ming) -> Plant:
	if ming in plant_database:
		var plant_data = plant_database[ming]
		var pl = plant_scene.instance()
		pl.set_plant(ming, plant_data)#plant.stages, plant.death)
		return pl
	print("DIDNT FIND PLANT: " + ming)
	return null
	
