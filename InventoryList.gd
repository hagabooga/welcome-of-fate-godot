tool
extends Panel

class_name InventoryList

var item_holder = load("res://InventoryUI/InventoryItemHolder.tscn")

export (int) var actual_slots = 50
var size : int setget set_size
export(String) var list_name : String
export(int) var item_column_size = 10


func _ready():
	set_item_holder()
	$GridContainer.columns = item_column_size
	$Label.text = list_name
	for x in range(actual_slots):
		var holder = item_holder.instance()
		$GridContainer.add_child(holder)
	self.size = actual_slots

func set_item_holder():
	item_holder = load("res://InventoryUI/InventoryItemHolder.tscn")
	
func set_size(val):
	size = val
	for x in range(size):
		$GridContainer.get_child(x).visible = true
	for x in range(size, actual_slots):
		#("YO")
		$GridContainer.get_child(x).visible = false
	resize_to_holder_amount(Control.PRESET_CENTER)


func resize_to_holder_amount(preset):
	rect_size.x = 32 * $GridContainer.columns + 10
	rect_size.y = 32 * (ceil(size/float(item_column_size))) + 10
	rect_position.y -= rect_size.y
	
	set_anchors_and_margins_preset(preset,3)

func get_holders() -> Array:
	return $GridContainer.get_children()
	

func add_item(item : Item):
	var first_null = null
	for holder in $GridContainer.get_children():
		if first_null == null and holder.item == null:
			first_null = holder
			#("wow")
		else:
			if holder.item != null and holder.item.ming == item.ming:
				holder.count += 1
				return
	first_null.set_item(item)