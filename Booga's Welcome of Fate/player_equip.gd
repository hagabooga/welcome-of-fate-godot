extends Node

var player_inventory

var item_count = {}
	
func equip(item):
	player_inventory.equip(item)
		
func remove_item_count(item):
	var index = player_inventory.find_idx(item)
	var key = item.ming
	if item_count.has(key):
		if item_count[key] == 1:
			player_inventory.find_node("InventoryItemList").remove_item(index)
			item_count.erase(key)
			#$ItemInfo/Inside.visible = false
		else:
			item_count[key] -= 1
	#print(item_count)