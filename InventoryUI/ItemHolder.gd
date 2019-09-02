extends TextureButton

class_name ItemHolder

var item : Item  = null setget set_item
var count = 0 setget set_count

signal holding
signal hovering(i)

func is_stackable():
	if item.base != "tool" and item.base != "weapon":
		return true
	return false

func get_texture():
	return $ItemTexture.texture

func set_count(val):
	count = val
	$ItemCount.text = str(count)

func _ready():
	connect("holding", ItemHoldTexture, "show_texture", [self])
	connect("hovering", ItemHoldTexture, "hovering_item")
	
func _process(delta):
	if is_hovered():
		emit_signal("hovering", item)
	
	
func set_item(i : Item, amt = 1):
	if i != null:
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
		if data != self and data.item.ming == item.ming:
			self.count += data.count
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
				
func consume():
	self.count -= 1
	if count <= 0:
		clear_holder()