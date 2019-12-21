extends Node2D

var items = {}

func add_item(item : Object):
	add_child(item)
	items[item.item.ming] = item
	

func give_item(ming : String):
	var item = items[ming]
	remove_child(item)
	return item