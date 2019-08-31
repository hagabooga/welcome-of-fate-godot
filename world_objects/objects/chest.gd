extends WorldObject

export(int) var size = 9


func right_clicked():
	return ClickAction.new(OPEN_OTHER_INVENTORY, [size, $InventoryList])

func _ready():
	$InventoryList.set_size(size)
	$InventoryList.resize_to_holder_amount(Control.PRESET_CENTER)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$InventoryList.visible = false
	