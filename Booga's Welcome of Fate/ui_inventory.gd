extends Panel



func _ready():
	$ItemList.focus_mode = 0
	visible = false
	$ItemInfo/Inside.visible = false
	add(item_database.make_item("Watering Can"))
	add(item_database.make_item("Hoe"))
	add(item_database.make_item("Turnip Seedbag"))
	#add(item_database.make_item("Sickle"))

func add(item):
	if (item != null):
		$ItemList.add_item(item.ming, load("res://sprites/items/" + item.ming.to_lower() + ".png"))
		var i = $ItemList.get_item_count()-1
		$ItemList.set_item_metadata(i, item)
		$ItemList.set_item_tooltip_enabled(i, false)


func set_labels(item):
	$ItemInfo/Inside.visible = true
	$ItemInfo/Inside/Info/Ming.text = item.ming
	$ItemInfo/Inside/Info/Desc.text = "%s (%s)" %[item.desc, item.type]
	$ItemInfo/Inside/StatsHolder.visible = false
	$ItemInfo/Inside/EquipEffect.visible = false
	if len(item.eff_desc) == 0:
		$ItemInfo/Inside/Info/Effect.visible = false
		$ItemInfo/Inside/Info/Desc2.visible = false
	else:
		$ItemInfo/Inside/Info/Effect.visible = true
		$ItemInfo/Inside/Info/Desc2.visible = true
		$ItemInfo/Inside/Info/Desc2.text = item.eff_desc

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	set_labels(item)

func _on_ItemList_item_activated(index):
	var item = $ItemList.get_item_metadata(index)
	if (item.act != -1):
		if (item.act == 1):
			var equip_item = $Equipment/EquipList.get_item_metadata(player_equip.dict_equip[item.type.to_lower()])
			if equip_item != null:
				add(equip_item)
		item.activate()
		$ItemList.remove_item(index)
		$ItemInfo/Inside.visible = false

func _on_EquipList_item_selected(index):
	var item = $Equipment/EquipList.get_item_metadata(index)
	if item != null:
		set_labels(item)


func _on_EquipList_item_activated(index):
	var item = $Equipment/EquipList.get_item_metadata(index)
	if (item != null):
		add(item)
		var type = item.type.to_lower()
		if (type == "tool"):
			type = "weapon"
		$Equipment/EquipList.set_item_icon(index, load("res://sprites/icons/%s.png"%type.to_lower()))
		$Equipment/EquipList.set_item_metadata(index, null)
		$ItemInfo/Inside.visible = false
	
