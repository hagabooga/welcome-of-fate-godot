extends CanvasLayer

onready var inventory : InventoryUI = get_node("Inventory")
onready var quest : QuestsUI = get_node("Quests")
onready var dialogue : DialogueUI = get_node("Dialogue")


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		close_all()
		
	if !$QuestionBox.visible:
		if Input.is_action_just_pressed("inventory"):
			open_close_inventory()
#		if Input.is_action_just_pressed("skill"):
#			open_close_skill()
		if Input.is_action_just_pressed("stats"):
			open_close_stats()
		if Input.is_action_just_pressed("options"):
			open_close_options()
		if Input.is_action_just_pressed("quest"):
			open_close_quests()


func create_question_box(question : String, target : Object, yes_func : String = "", no_func : String = ""):
	$QuestionBox/Buttons/NoButton.emit_signal("pressed")
	$Inventory/InventoryList.visible = false
	$QuestionBox.visible = true
	$QuestionBox/Question.text = question
	var buttons = [$QuestionBox/Buttons/YesButton, $QuestionBox/Buttons/NoButton]
	if yes_func != "":
		$QuestionBox/Buttons/YesButton.connect("pressed", target, yes_func)
	if no_func != "":
		$QuestionBox/Buttons/NoButton.connect("pressed", target, no_func)
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

#func open_close_skill(opposite = true, yes=false):
#	if opposite:
#		$Skills.visible = !$Skills.visible
#	else:
#		$Skills.visible = yes
#	if !$Skills.visible:
#		for x in $Skills/Pages.get_children():
#			var page = x.find_node("SkillTree")
#			if page.visible:
#				page.visible = false
#				break

func open_close_stats(opposite = true, yes=false):
	if opposite:
		$Stats.visible = !$Stats.visible
	else:
		$Stats.visible = yes
	
func open_close_options(opposite = true, yes=false):
	if opposite:
		$Options.visible = !$Options.visible
	else:
		$Options.visible = yes

func open_close_quests(opposite = true, yes=false):
	if opposite:
		$Quests.visible = !$Quests.visible
	else:
		$Quests.visible = yes
		
func unfreeze_time():
	$Date.unfreeze_time()
	

func close_all():
	open_close_inventory(false)
#	open_close_skill(false)
	open_close_stats(false)
	open_close_options(false)
	open_close_quests(false)
