extends Control


class_name InventoryUI

var hotkey_selected_index = 0
var inventory_items : Array
var hotkey_items : Array

var holding_item : ItemHolderBase = null

var hotkey_index = 0 setget set_hotkey_index

var cash  : int setget set_cash

func set_cash(x):
	cash = x
	$CashAmount.text = "Cash: %s"%cash

func pay(value):
	self.cash -= value


signal on_hotkey_index_change

func set_watering_can_ui():
	var watering_can = get_hotkey_item()
	$WateringCanAmount/TextureProgress.value = \
	(watering_can.current_amount / float(watering_can.capacity)) * $WateringCanAmount/TextureProgress.max_value

func check_watering_can():
	var can = get_hotkey_item()
	if can == null:
		return
	var yes = can.type == "watering can"
	if yes:
		set_watering_can_ui()
		if !can.is_connected("on_set_amount", self, "set_watering_can_ui"):
			can.connect("on_set_amount", self, "set_watering_can_ui")
	$WateringCanAmount.visible = yes

func set_hotkey_index(val):
	hotkey_index = val
	$HotkeyList/HotkeySelection.rect_global_position = $HotkeyList/HBoxContainer.get_child(hotkey_index).rect_global_position
	check_watering_can()
	emit_signal("on_hotkey_index_change")
	

func get_hotkey_holder():
	return $HotkeyList/HBoxContainer.get_child(hotkey_index)
	
func get_hotkey_item() -> Item:
	return $HotkeyList/HBoxContainer.get_child(hotkey_index).item

func _ready():
	self.cash = 3500
	set_new_inventory_size(30)
	#set_other_inventory_size(10)
	inventory_items = $InventoryList/GridContainer.get_children()
	hotkey_items = $HotkeyList/HBoxContainer.get_children()
	add_item(item_database.make_item("hoe"))
	add_item(item_database.make_item("watering can"))
	add_item(item_database.make_item("turnip seedbag"))
	add_item(item_database.make_item("radish seedbag"))
	add_item(item_database.make_item("axe"))
	add_item(item_database.make_item("hammer"))
	add_item(item_database.make_item("sickle"))
	add_item(item_database.make_item("magic wand"))
	#add_item(item_database.make_item("wooden plank"))
	#add_item(item_database.make_item("stone"))
	#add_item(item_database.make_item("weed"))
	
	for x in range(30):
		add_item(item_database.make_item("turnip"))
		add_item(item_database.make_item("health potion"))
		add_item(item_database.make_item("mana potion"))
		add_item(item_database.make_item("energy potion"))
		add_item(item_database.make_item("soul potion"))
		add_item(item_database.make_item("vitality potion"))
		add_item(item_database.make_item("spirit potion"))

	for items in [inventory_items, hotkey_items]:
		for item in items:
			item.inventory_ui = self

	for x in hotkey_items:
		x.connect("holding", self, "set_hotkey_index", [x.get_index()])
		#x.connect("holding", self, "emit_signal", ["on_hotkey_index_change"])
	self.hotkey_index = 0
	
	
func set_new_inventory_size(size):
	$InventoryList.size = size
	resize_inventory()

func resize_inventory():
	$InventoryList.resize_to_holder_amount(Control.PRESET_CENTER_BOTTOM)
	$InventoryList.rect_position.y -= 42

	
func _process(delta):
	if !owner.owner.can_move:
		return
	
	
	if Input.is_action_just_released("scroll_down"):
		if hotkey_index < $HotkeyList/HBoxContainer.get_child_count() - 1:
			self.hotkey_index += 1
		else:
			self.hotkey_index = 0
		#emit_signal("on_hotkey_index_change")
	if Input.is_action_just_released("scroll_up"):
		if hotkey_index > 0:
			self.hotkey_index -= 1
		else:
			self.hotkey_index = $HotkeyList/HBoxContainer.get_child_count() - 1
		#emit_signal("on_hotkey_index_change")
	for x in range(10):
		if Input.is_action_just_pressed("inv_hotkey_" + str(x)):
			if x == 0:
				self.hotkey_index = 9
			else:
				self.hotkey_index = x - 1
			#emit_signal("on_hotkey_index_change")

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
