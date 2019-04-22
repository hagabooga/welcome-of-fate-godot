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
	$Panel/Tool.add_icon_item(load("res://sprites/icons/shovel.png"))

func _on_EquipList_item_selected(index):
	var item = $EquipList.get_item_metadata(index)
	if item != null:
		get_parent().inventory.set_labels(item)


func _on_EquipList_item_activated(index):
	var item = $EquipList.get_item_metadata(index)
	if (item != null):
		get_parent().inventory.unequip(index)
		var ming = item.type
		if item.base == "weapon":
			ming = item.base
		$EquipList.set_item_icon(index, load("res://sprites/icons/%s.png"%ming))
		$EquipList.set_item_metadata(index, null)
		get_parent().inventory.find_node("ItemInfo").find_node("Inside").visible = false

func _on_Tool_item_selected(index):
	var item = $Panel/Tool.get_item_metadata(index)
	if item != null:
		get_parent().inventory.set_labels(item)

func _on_Tool_item_activated(index):
	get_parent().inventory.unequip_tool()
