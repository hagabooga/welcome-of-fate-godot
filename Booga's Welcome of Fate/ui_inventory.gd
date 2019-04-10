extends ItemList


func add(item):
	add_item(item.ming, load("res://sprites/items/" + item.ming.to_lower() + ".png"))
	print(get_item_count())
	var i = get_item_count()-1
	set_item_metadata(i, item)
	var actual_item = get_item_metadata(i)