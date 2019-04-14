extends Panel

func _ready():
	$ItemList.focus_mode = 0
	visible = false
	$ItemInfo/Inside.visible = false
	

func add(item):
	$ItemList.add_item(item.ming, load("res://sprites/items/" + item.ming.to_lower() + ".png"))
	#print(get_item_count())
	var i = $ItemList.get_item_count()-1
	$ItemList.set_item_metadata(i, item)
	$ItemList.set_item_tooltip_enabled(i, false)
	#var actual_item = get_item_metadata(i)




func _on_ItemList_item_selected(index):
	$ItemInfo/Inside.visible = true
	var item = $ItemList.get_item_metadata(index)
	$ItemInfo/Inside/Info/Ming.text = item.ming
	$ItemInfo/Inside/Info/Desc.text = "%s (%s)" %[item.desc, item.type]
	if (item.type == "Plant"):
		$ItemInfo/Inside/StatsHolder.visible = false
		$ItemInfo/Inside/EquipEffect.visible = false
		$ItemInfo/Inside/Info/Effect/Desc.text = item.eff_desc

	
func _on_ItemList_item_activated(index):
	var item = $ItemList.get_item_metadata(index)
	item.activate()
	$ItemList.remove_item(index)
	



