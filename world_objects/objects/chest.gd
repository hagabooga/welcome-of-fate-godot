tool

extends WorldObject

class_name Chest

export(int) var size = 9


func right_clicked():
	$Node2D.visible = true

func _ready():
	$Node2D/Control/InventoryList.set_size(size)
	$Node2D/Control/InventoryList.resize_to_holder_amount(Control.PRESET_CENTER)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Node2D.visible = false


func _on_Button_pressed():
	$Node2D.visible = false


func _on_CloseInvArea_body_exited(body):
	if body.name == "Player":
		_on_Button_pressed()
