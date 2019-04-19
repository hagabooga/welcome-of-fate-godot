extends Node

var item_database
var weapons = ["wand"]


func _ready():
	var file = File.new()
	file.open("res://items.json", file.READ)
	item_database = parse_json(file.get_as_text())

func find_item(mingz):
	for x in item_database:
		if x == mingz:
			return(make_item(x))

func make_item(ming):
	var x = item_database[ming]
	var i
	if x.type.to_lower() in weapons:
		i = Weapon.new(ming,x.desc,x.eff_desc,x.cost,x.type, x.activate, -1, x.stats)
	else:
		if x.has("color"):
			i = Item.new(ming,x.desc,x.eff_desc,x.cost,x.type, x.activate, x.color)
		else:
			i = Item.new(ming,x.desc,x.eff_desc,x.cost,x.type, x.activate, -1)
	return i

