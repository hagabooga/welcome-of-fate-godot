extends Node

var npc_database
var weapons = ["wand"]


func _ready():
	var file = File.new()
	file.open("res://npc.json", file.READ)
	npc_database = parse_json(file.get_as_text())

func find_npc(mingz):
	for x in npc_database:
		if x == mingz:
			return npc_database[x]