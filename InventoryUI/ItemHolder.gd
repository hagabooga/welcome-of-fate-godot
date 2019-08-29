extends TextureButton

class_name ItemHolder

var item : Item  = null setget set_item
var count = 0 setget set_count

signal holding
signal released



func is_stackable():
	if item.base != "tool":
		return true
	return false

func set_count(val):
	count = val
	$ItemCount.text = str(count)

func _ready():
	pass
	
func set_item(i : Item, amt = 1):
	item = i
	$ItemTexture.texture = load("res://sprites/items/" + item.ming + ".png")
	self.count = amt
	$ItemTexture.modulate.a = 1
	if is_stackable():
		$ItemCount.visible = true
	else:
		$ItemCount.visible = false
		
func holding():
	$ItemTexture.modulate.a = 0.4
	
func released():
	$ItemTexture.modulate.a = 1
	
func clear_holder():
	item = null
	self.count = 0
	$ItemCount.text	= ""
	$ItemTexture.modulate.a = 1
	$ItemTexture.texture = null

func get_drag_data(position):
	return self

func can_drop_data(position, data):
	return data.item != null

func drop_data(position, data):
	if item == null:
		set_item(data.item, data.count)
		data.clear_holder()
	else:
		var save = [item, count]
		set_item(data.item, data.count)
		data.set_item(save[0], save[1])

func _on_ItemHolder_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				holding()
				emit_signal("holding")