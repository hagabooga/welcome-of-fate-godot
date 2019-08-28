extends Control


var hotkey_selected_index = 0
var inventory_items : Array
var hotkey_items : Array

var holding_item : ItemHolder = null

func _ready():
	inventory_items = $InventoryList/GridContainer.get_children()
	hotkey_items = $HotkeyList/HBoxContainer.get_children()
	#add_item(item_database.make_item("turnip"))
	inventory_items[7].item = item_database.make_item("branch")
	#add_item(item_database.make_item("rock"))
	for items in [inventory_items, hotkey_items]:
		for item in items:
			item.connect("holding", self, "show_texture", [item])
	
func _process(delta):
	if holding_item != null and Input.is_action_just_released("interact"):
		remove_hold_texture()
		holding_item.released()
		holding_item = null
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
	if $ItemHold.visible:
		var pos = get_local_mouse_position()
		pos.x -= $ItemHold.rect_size.x
		pos.y -= $ItemHold.rect_size.y
		$ItemHold.rect_position = pos
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

func show_texture(holder : ItemHolder):
	$ItemHold.visible = true
	$ItemHold.texture = holder.find_node("ItemTexture").texture
	holding_item = holder
	
func remove_hold_texture():
	$ItemHold.visible = true
	$ItemHold.texture = null

func set_tooltip_labels(holder : ItemHolder):
	$Tooltip.visible = true
	$Tooltip/VBoxContainer/Ming.text = holder.item.ming.capitalize() 
	$Tooltip/VBoxContainer/Desc.text = "%s (%s)"%[holder.item.desc, holder.item.type]
	$Tooltip/VBoxContainer/Cost.text = "Cost: $%d"%holder.item.cost
	$Tooltip/VBoxContainer/Eff_Desc.text = holder.item.eff_desc