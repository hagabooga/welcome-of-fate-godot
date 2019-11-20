extends Node

var skill_database

func _ready():
	var file = File.new()
	file.open("res://skills.json", file.READ)
	skill_database = parse_json(file.get_as_text())
	file.close()

func make_skill(mingz):
	var x = skill_database[mingz]
	var skil = Skill.new(mingz, x.desc, x.max_rank)
	return skil
	