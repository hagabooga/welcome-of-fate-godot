extends Panel



func _ready():
	$EquipList.add_icon_item(load("res://sprites/icons/accessory.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/head.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/neck.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/weapon.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/body.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/shield.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/boots.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/bottom.png"))
	$EquipList.add_icon_item(load("res://sprites/icons/gloves.png"))

