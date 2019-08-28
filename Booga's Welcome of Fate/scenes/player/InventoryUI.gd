extends Control


var hotkey_selected_index = 0
var inventory_items : Array
var hotkey_items : Array

var holding_item : ItemHolder = null
var original_holding_item_index = null
var is_inventory_item_holding = false

func _ready():
	inventory_items = $InventoryList/GridContainer.get_children()
	hotkey_items = $HotkeyList/HBoxContainer.get_children()
	#add_item(item_database.make_item("turnip"))
	#inventory_items[7].item = item_database.make_item("branch")
	#add_item(item_database.make_item("rock"))
	for items in [inventory_items, hotkey_items]:
		for item in items:
			item.connect("pressed", self, "clicked_item_holder", [item])
	
func _process(delta):
	#print(holding_item)
	if holding_item != null and !$InventoryList.visible:
		holding_item.set_item(holding_item.item, holding_item.count)
		holding_item = null
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
#	if Input.is_action_just_released("scroll_up") and hotkey_selected_index < $HotkeyList/HotkeyItemList.get_item_count() - 1:
#		hotkey_selected_index += 1
#		$HotkeyList/HotkeyItemList.select(hotkey_selected_index)
#	if Input.is_action_just_released("scroll_down") and hotkey_selected_index > 0:
#		hotkey_selected_index -= 1
#		$HotkeyList/HotkeyItemList.select(hotkey_selected_index)

func add_item(item : Item):
	var first_null = null
	for items in [hotkey_items, inventory_items]:
		for x in items:
			if first_null == null and x.item == null:
				first_null = x
			else:
				if x.item != null and x.item.ming == item.ming:
					x.count += 1
					return
	first_null.set_item(item)

func clicked_item_holder(holder : ItemHolder):
	if !$InventoryList.visible:
		return
	# pick up item
	if holding_item == null and holder.item != null:
		print("yo")
		holder.holding()
		holding_item = holder
		#holder.clear_holder()
	else:
		if holding_item == null and holding_item == null:
			return
		#if holder empty, put holding one in this one
		if holder.item == null:
			print("set empty")
			holder.set_item(holding_item.item, holding_item.count)
			holding_item.clear_holder()
			holding_item = null
		else:
			# item into item
			if holder.item.ming == holding_item.item.ming:
				holder.count += holding_item.count
				holding_item.clear_holder()
				holding_item = null
			else:
				var save = [holder.item, holder.count]
				holder.set_item(holding_item.item, holding_item.count)
				holding_item.set_item(save[0],save[1])
				holding_item = null


func set_tooltip_labels(holder : ItemHolder):
	$Tooltip.visible = true
	$Tooltip/VBoxContainer/Ming.text = holder.item.ming.capitalize() 
	$Tooltip/VBoxContainer/Desc.text = "%s (%s)"%[holder.item.desc, holder.item.type]
	$Tooltip/VBoxContainer/Cost.text = "Cost: $%d"%holder.item.cost + " | Amount: " + str(holder.count)
	$Tooltip/VBoxContainer/Eff_Desc.text = holder.item.eff_desc