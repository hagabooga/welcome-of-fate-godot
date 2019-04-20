extends Node2D

var tool_itemList
var tool_action
var player_change_tool_sprite
var equipment_itemList
var inventory

func _ready():
	inventory = $Inventory
	tool_itemList = $Equipment/Panel/Tool
	tool_action = $Tool
	player_change_tool_sprite = $PlayerChangeToolSprite
	equipment_itemList = $Equipment/EquipList



func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
