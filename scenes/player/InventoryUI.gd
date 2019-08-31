extends Control


var hotkey_selected_index = 0
var inventory_items : Array
var hotkey_items : Array
var other_inventory_items : Array

var holding_item : ItemHolder = null

var hotkey_index = 0 setget set_hotkey_index

func set_hotkey_index(val):
	hotkey_index = val
	$HotkeyList/HotkeySelection.rect_global_position = $HotkeyList/HBoxContainer.get_child(hotkey_index).rect_global_position
	
	
func get_hotkey_item() -> Item:
	return $HotkeyList/HBoxContainer.get_child(hotkey_index).item

func _ready():
	set_new_inventory_size(10)
	#set_other_inventory_size(10)
	inventory_items = $InventoryList/GridContainer.get_children()
	hotkey_items = $HotkeyList/HBoxContainer.get_children()
	other_inventory_items = $OtherInventoryList/GridContainer.get_children()
	add_item(item_database.make_item("turnip"))
	add_item(item_database.make_item("rock"))
	add_item(item_database.make_item("hoe"))
	add_item(item_database.make_item("watering can"))
	add_item(item_database.make_item("turnip seedbag"))
	add_item(item_database.make_item("axe"))
	add_item(item_database.make_item("hammer"))
	add_item(item_database.make_item("sickle"))
	add_item(item_database.make_item("wooden plank"))
	add_item(item_database.make_item("stone"))
	add_item(item_database.make_item("weed"))
	for items in [inventory_items, hotkey_items, other_inventory_items]:
		for item in items:
			item.connect("holding", self, "show_texture", [item])
	for x in hotkey_items:
		x.connect("holding", self, "set_hotkey_index", [x.get_index()])
	
	
func set_new_inventory_size(size):
	$InventoryList.size = size
	resize_inventory()
	$OtherInventoryList.rect_position.y -= (42 + $InventoryList.rect_size.y)

func resize_inventory():
	$InventoryList.resize_to_holder_amount(Control.PRESET_CENTER_BOTTOM)
	$InventoryList.rect_position.y -= 42
	resize_other_inventory()

func set_other_inventory_size(size):
	$OtherInventoryList.size = size
	resize_other_inventory()

func resize_other_inventory():
	print("yo")
	$OtherInventoryList.resize_to_holder_amount(Control.PRESET_CENTER_BOTTOM)
	$OtherInventoryList.rect_position.y -= (42 + $InventoryList.rect_size.y)
	

	
func _process(delta):
	if holding_item != null and Input.is_action_just_released("interact"):
		remove_hold_texture()
		holding_item.released()
		holding_item = null
	$Tooltip.visible = false
	for items in [inventory_items, hotkey_items, other_inventory_items]:
		for item in items:
			if item != null and item.is_hovered() and item.item != null:
				set_tooltip_labels(item)
				break
	if $Tooltip.visible:
		var pos = get_local_mouse_position()
		pos.y -= $Tooltip.rect_size.y
		$Tooltip.rect_position = pos
	if $ItemHold.visible:
		var pos = get_local_mouse_position()
		pos.x -= $ItemHold.rect_size.x/2
		pos.y -= $ItemHold.rect_size.y/2
		$ItemHold.rect_position = pos
	
	if Input.is_action_just_released("scroll_down"):
		if hotkey_index < $HotkeyList/HBoxContainer.get_child_count() - 1:
			self.hotkey_index += 1
		else:
			self.hotkey_index = 0
	if Input.is_action_just_released("scroll_up"):
		if hotkey_index > 0:
			self.hotkey_index -= 1
		else:
			self.hotkey_index = $HotkeyList/HBoxContainer.get_child_count() - 1

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
	$Tooltip/VBoxContainer/Desc.text = "%s (%s)"%[holder.item.desc, holder.item.type.capitalize()]
	$Tooltip/VBoxContainer/Cost.text = "Cost: $%d"%holder.item.cost
	$Tooltip/VBoxContainer/Eff_Desc.text = holder.item.eff_desc