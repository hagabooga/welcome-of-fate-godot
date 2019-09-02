tool

extends WorldObject

class_name Chest



func clicked(tewl: Item):
	if tewl != null and tewl.type == "axe":
		var items_to_add = ["chest"]
		for x in $Node2D/Control/InventoryList/GridContainer.get_children():
			if x.item != null:
				for y in range(x.count):
					items_to_add.append(x.item.ming)
		queue_free()
		return ClickAction.new(ADD_ITEM, items_to_add)

func right_clicked():
	$Node2D.visible = true

func _ready():
	$Node2D/Control/InventoryList.resize_to_holder_amount(Control.PRESET_CENTER)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Node2D.visible = false


func _on_Button_pressed():
	$Node2D.visible = false

func _on_CloseInvArea_body_exited(body):
	if body.name == "Player":
		_on_Button_pressed()

