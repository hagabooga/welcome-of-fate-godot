extends Node

var quest_database

func _ready():
	var file = File.new()
	file.open("res://quests.json", file.READ)
	quest_database = parse_json(file.get_as_text())

func find_quest(mingz):
	for x in quest_database:
		if x == mingz:
			return quest_database[x]