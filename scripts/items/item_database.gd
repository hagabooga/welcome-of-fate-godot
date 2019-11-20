extends Node

var item_database
var weapons = ["wand"]


func _ready():
	var file = File.new()
	file.open("res://items.json", file.READ)
	item_database = parse_json(file.get_as_text())
	file.close()

func make_item(ming) -> Item:
	var x = item_database[ming]
	var i
	if x.has("base"):
		if x.base == "tool":
			if x.type == "watering can":
				i = WateringCan.new(ming,x.desc,x.eff_desc,x.cost,x.base, x.type, x.activate, -1, x.energy, x.capacity)
			else:
				i = ToolItem.new(ming,x.desc,x.eff_desc,x.cost,x.base, x.type, x.activate, -1, x.energy)
		
		elif x.base == "weapon" || x.base == "armor":
			i = EquipItem.new(ming,x.desc,x.eff_desc,x.cost,x.base, x.type, x.activate, -1, x.stats)
	else:
		if !x.has("placeable"):
			i = Item.new(ming,x.desc,x.eff_desc,x.cost,x.type, x.activate, true)
		else:
			i = Item.new(ming,x.desc,x.eff_desc,x.cost,x.type, x.activate, x.placeable)
	return i

