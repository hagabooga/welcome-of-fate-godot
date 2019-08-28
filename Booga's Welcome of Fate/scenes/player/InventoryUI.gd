extends Control


var hotkey_selected_index = 0
var inventory_items : Array
var hotkey_items : Array

func _ready():
	inventory_items = $InventoryList/GridContainer.get_children()
	hotkey_items = $HotkeyList/HBoxContainer.get_children()
	add_item(item_database.make_item("turnip"))
	inventory_items[7].item = item_database.make_item("branch")
	add_item(item_database.make_item("rock"))
	
func _process(delta):
	#if Input.is_action_just_pressed("action"):
		#add_item(item_database.make_item("rock"))
	$Tooltip.visible = false
	for items in [inventory_items, hotkey_items]:
		for item in items:
			if item.is_hovered() and item.item != null:
				set_tooltip_labels(item)
				break
	if $Tooltip.visible:
		var pos = get_local_mouse_position()
		pos.y -= $Tooltip.rect_size.y
		$Tooltip.rect_position = pos
	if Input.is_action_just_released("scroll_up") and hotkey_selected_index < $HotkeyList/HotkeyItemList.get_item_count() - 1:
		hotkey_selected_index += 1
		$HotkeyList/HotkeyItemList.select(hotkey_selected_index)
	if Input.is_action_just_released("scroll_down") and hotkey_selected_index > 0:
		hotkey_selected_index -= 1
		$HotkeyList/HotkeyItemList.select(hotkey_selected_index)


func add_item(item : Item):
	var first_null = null
	for x in inventory_items:
		if x.item == null and first_null == null:
			first_null = x
		else:
			if x.item != null and x.item.ming == item.ming:
				x.count += 1
				return
	first_null.set_item(item)


func set_tooltip_labels(holder : ItemHolder):
	$Tooltip.visible = true
	$Tooltip/VBoxContainer/Ming.text = holder.item.ming.capitalize() 
	$Tooltip/VBoxContainer/Desc.text = "%s (%s)"%[holder.item.desc, holder.item.type]
	$Tooltip/VBoxContainer/Cost.text = "Cost: $%d"%holder.item.cost + " | Amount: " + str(holder.count)
	$Tooltip/VBoxContainer/Eff_Desc.text = holder.item.eff_desc