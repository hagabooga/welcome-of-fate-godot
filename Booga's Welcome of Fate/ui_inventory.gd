extends Panel


func _ready():
	$InventoryItemList.focus_mode = 0
	visible = false
	$ItemInfo/Inside.visible = false
	add(item_database.make_item("watering can"))
	add(item_database.make_item("hoe"))
	add(item_database.make_item("turnip seedbag"))
	add(item_database.make_item("magic wand"))
	add(item_database.make_item("turnip"))
	add(item_database.make_item("katana"))
	#add(item_database.make_item("Sickle"))


			
func quick_change_tool(rev):
	var item = find_type("tool",rev)
	equip(item)
	get_parent().player_change_tool_sprite.set_texture("res://sprites/items/%s.png"%item.ming)

func find_type(type, rev):
	var r
	if (rev):
		r = range($InventoryItemList.get_item_count()-1,-1,-1)
	else:
		r = range($InventoryItemList.get_item_count())
	print(r)
	for x in r:
		var item = $InventoryItemList.get_item_metadata(x)
		if item.type == type:
			return item	

func find_idx(item):
	for x in range($InventoryItemList.get_item_count()):
		var search_item = $InventoryItemList.get_item_metadata(x)
		if search_item.ming == item.ming:
			return x

func add(item):
	if (item != null):
		var key = item.ming
		if !player_equip.item_count.has(key):
			player_equip.item_count[key] = 1
			$InventoryItemList.add_item(item.ming.capitalize(), load("res://sprites/items/" + item.ming + ".png"))
			var i = $InventoryItemList.get_item_count()-1
			$InventoryItemList.set_item_metadata(i, item)
			$InventoryItemList.set_item_tooltip_enabled(i, false)
		else:
			player_equip.item_count[key] += 1
		var selected = $InventoryItemList.get_selected_items()
		if len(selected) > 0:
			var item_selected = $InventoryItemList.get_item_metadata(selected[0])
			if item_selected.ming == item.ming:
				set_labels(item_selected)


func set_labels(item):
	$ItemInfo/Inside.visible = true
	if player_equip.item_count.has(item.ming) and player_equip.item_count[item.ming] > 1:
		$ItemInfo/Inside/Info/Ming.text = "%s x%d"%[item.ming.capitalize(), player_equip.item_count[item.ming]]
	else:
		$ItemInfo/Inside/Info/Ming.text = "%s"%[item.ming.capitalize()]
	$ItemInfo/Inside/Info/Desc.text = "%s (%s)" %[item.desc, item.type.capitalize()]
	if item.base == "weapon":
		$ItemInfo/Inside/Title.visible = true
		$ItemInfo/Inside/EquipEffect.visible = true
		$ItemInfo/Inside/Info/Effect.visible = false
		$ItemInfo/Inside/Info/Desc2.visible = false
		$ItemInfo/Inside/EquipEffect/Desc.text = item.eff_desc
		for x in $ItemInfo/Inside/Title/StatsHolder.get_children():
			x.queue_free()
		for x in item.stats.stats:
			if x.value != 0:
				var new_label = Label.new()
				new_label.align = Label.ALIGN_CENTER
				print(x.type)
				var type = global_id.stat_idToName[x.type].capitalize()
				if x.value > 0:
					new_label.text = "%s: +%d"%[type, x.value]
				else:
					new_label.text = "%s: %d"%[type, x.value]
				var font = DynamicFont.new()
				font.font_data = load("res://segoeuil.ttf")
				font.size = 18
				new_label.add_font_override("font", font)
				$ItemInfo/Inside/Title/StatsHolder.add_child(new_label)
	else:
		$ItemInfo/Inside/Title.visible = false
		$ItemInfo/Inside/EquipEffect.visible = false
		if len(item.eff_desc) == 0:
			$ItemInfo/Inside/Info/Effect.visible = false
			$ItemInfo/Inside/Info/Desc2.visible = false
		else:
			$ItemInfo/Inside/Info/Effect.visible = true
			$ItemInfo/Inside/Info/Desc2.visible = true
			$ItemInfo/Inside/Info/Desc2.text = item.eff_desc

func _on_ItemList_item_selected(index):
	var item = $InventoryItemList.get_item_metadata(index)
	set_labels(item)

func _on_ItemList_item_activated(index):
	var item = $InventoryItemList.get_item_metadata(index)
	if (item.act != -1):
		item.activate()
		print(player_equip.item_count)


func equip(item):
	if (item.type == "tool"):
		unequip_tool()
		var split_name = item.ming.split(" ")
		if len(split_name) > 1:
			if split_name[1] == "seedbag":
				var tewl = get_parent().tool_action
				tewl.set_script(load("res://scripts/tools/" + split_name[1] + ".gd"))
				tewl.plant_ming = split_name[0]
				tewl.set_color(item.color)
				get_parent().tool_itemList.set_item_icon(0, load("res://sprites/items/%s.png"%item.ming))
				get_parent().tool_itemList.set_item_metadata(0,item)
			else:
				equip_tool(item)
		else:
			equip_tool(item)
	elif item.base == "weapon":
		unequip(3)
		get_parent().equipment_itemList.set_item_icon(3, load("res://sprites/items/%s.png"%item.ming.to_lower()))
		get_parent().equipment_itemList.set_item_metadata(3,item)
		player_stats.add_attrib(item.stats)
		player_stats.print_stats_bonuses()
	player_equip.remove_item_count(item)

func unequip(index):
	var current_weapon = get_parent().equipment_itemList.get_item_metadata(index)
	if current_weapon != null:
		player_stats.remove_attrib(current_weapon.stats)
		add(current_weapon)
		player_stats.print_stats_bonuses()
	
func equip_tool(item):
	get_parent().tool_action.set_script(load("res://scripts/tools/" + item.ming + ".gd"))
	get_parent().tool_itemList.set_item_icon(0, load("res://sprites/items/%s.png"%item.ming))
	get_parent().tool_itemList.set_item_metadata(0,item)

func unequip_tool():
	var tool_item = get_parent().tool_itemList
	var current_tool = tool_item.get_item_metadata(0)
	if current_tool != null:
		add(current_tool)
		tool_item.set_item_icon(0, load("res://sprites/icons/shovel.png"))
		tool_item.set_item_metadata(0, null)
		$ItemInfo/Inside.visible = false