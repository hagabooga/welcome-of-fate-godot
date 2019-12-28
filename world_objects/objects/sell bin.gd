extends WorldObject

func right_clicked():
	$Node2D.visible = true

func _ready():
	$Node2D/Control/InventoryList.resize_to_holder_amount(Control.PRESET_CENTER)
	world_globals.connect("next_day", self, "sell_items")
	ming = "sell bin"

func sell_items():
	for x in $Node2D/Control/InventoryList.find_node("GridContainer").get_children():
		if x.item != null:
			get_tree().get_current_scene().player.add_cash(x.item.cost * x.count)
			x.clear_holder()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Node2D.visible = false


func _on_Button_pressed():
	$Node2D.visible = false

func _on_CloseInvArea_body_exited(body):
	if body.name == "Player":
		_on_Button_pressed()
