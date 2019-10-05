extends Control


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		open_close_inventory(false)
	if Input.is_action_just_pressed("inventory") and !$QuestionBox.visible:
		open_close_inventory()
	if Input.is_action_just_pressed("skill") and !$QuestionBox.visible:
		open_close_skill()
	# hotkey 1-9-0 keyboard
	

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

func open_close_inventory(opposite = true, yes=false):
	if opposite:
		$Inventory/InventoryList.visible = !$Inventory/InventoryList.visible
	else:
		$Inventory/InventoryList.visible = yes
	$Inventory/CashAmount.visible = $Inventory/InventoryList.visible

func open_close_skill(opposite = true, yes=false):
	if opposite:
		$Skills.visible = !$Skills.visible
	else:
		$Skills.visible = yes
	if !$Skills.visible:
		for x in $Skills/Pages.get_children():
			var page = x.find_node("SkillTree")
			if page.visible:
				page.visible = false
				break


func unfreeze_time():
	$Date.unfreeze_time()
