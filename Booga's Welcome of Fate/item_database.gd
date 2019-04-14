extends Node

var item = load("res://item.gd")
var item_database

func _ready():
	var file = File.new()
	file.open("res://items.json", file.READ)
	item_database = parse_json(file.get_as_text())
	##print(item_database)

func find_item(mingz):
	var it
	for x in item_database:
		if x == mingz:
			return(make_item(x))

func make_item(ming):
	var x = item_database[ming]
	var i = item.new(ming,x.desc,x.eff_desc,x.cost,x.type, x.activate)
	return i

