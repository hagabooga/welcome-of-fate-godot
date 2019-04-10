extends Node

var item = load("res://item.gd")


var items = []
var item_database

func _ready():
	var file = File.new()
	file.open("res://items_plant.json", file.READ)
	item_database = parse_json(file.get_as_text())
	#print(item_database)

func find_item(mingz):
	var it
	for x in item_database:
		#print(x)
		if x == mingz:
			return(make_item(x))

func add_item(mingz):
	items.push_front(find_item(mingz))

func make_item(ming):
	var x = item_database[ming]
	var i = item.new(ming,x.cost)
	return i