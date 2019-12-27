extends Node2D

var items = {}

func add_item(i):
	if i is Item:
		if i.base != "tool" and i.base != "weapon":
			return
		if i.ming in items:
			return
		var weapon = load("res://scenes/weapons/%s.tscn"%i.ming).instance()
		weapon.item = i
		i = weapon
	items[i.item.ming] = i
	add_child(i)

func give_item(ming : String):
	var item = items[ming]
	remove_child(item)
	return item