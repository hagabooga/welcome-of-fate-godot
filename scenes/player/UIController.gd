extends Control


func _process(delta):
	if (Input.is_action_just_pressed("inventory") || Input.is_action_just_pressed("ui_cancel")) and !$QuestionBox.visible:
		$Inventory/InventoryList.visible = !$Inventory/InventoryList.visible
	# hotkey 1-9-0 keyboard
	for x in range(48,58):
		if Input.is_key_pressed(x):
			if x == 48:
				$Inventory.hotkey_index = 9
			else:
				$Inventory.hotkey_index = x - 49

func create_question_box(question : String, target : Object, yes_func : String = "", no_func : String = ""):
	$QuestionBox/Buttons/NoButton.emit_signal("pressed")
	$Inventory/InventoryList.visible = false
	$QuestionBox.visible = true
	$QuestionBox/Question.text = question
	var buttons = [$QuestionBox/Buttons/YesButton, $QuestionBox/Buttons/NoButton]
	if yes_func != "":
		$QuestionBox/Buttons/YesButton.connect("pressed", target, yes_func)
	if no_func != "":
		pass
		#button_connect_and_delete($QuestionBox/NoButton, "pressed", target, no_func)
	for x in buttons:
		x.connect("pressed", $QuestionBox, "button_press")
		x.connect("pressed", $QuestionBox, "delete_all_button_connections", [x, "pressed"])
	#print($QuestionBox/YesButton.get_signal_connection_list("pressed"))

func unfreeze_time():
	$Date.unfreeze_time()
