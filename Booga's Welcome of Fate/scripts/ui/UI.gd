extends Node2D

var tool_itemList
var tool_action
var player_change_tool_sprite
var equipment_itemList
var inventory
var weapon
var current_left_ui = null
var current_right_ui = null
var can_open_ui = true

func _ready():
	inventory = $Inventory
	tool_itemList = $Equipment/Panel/Tool
	equipment_itemList = $Equipment/EquipList
	$Inventory.visible = false
	$Equipment.visible = false



func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		close_all_open_ui()
	if (can_open_ui):
		if Input.is_action_just_pressed("inventory"):
			open_close_right_ui($Inventory)
		if Input.is_action_just_pressed("quest"):
			open_close_left_ui($Quests)
		if Input.is_action_just_pressed("equipment"):
			open_close_left_ui($Equipment)
			

func close_all_open_ui():
	if not !current_left_ui:
			current_left_ui.visible = false
			current_left_ui = null
	if not !current_right_ui:
		current_right_ui.visible = false
		current_right_ui = null


func open_close_left_ui(ui):
	ui.visible = !ui.visible
	if ui.visible:
		if current_left_ui == null:
			current_left_ui = ui
		else:
			current_left_ui.visible = !current_left_ui.visible
			current_left_ui = ui
	else:
		current_left_ui = null

func open_close_right_ui(ui):
	ui.visible = !ui.visible
	if ui.visible:
		if current_right_ui == null:
			current_right_ui = ui
		else:
			current_right_ui.visible = !current_right_ui.visible
			current_right_ui = ui
	else:
		current_right_ui = null
	
