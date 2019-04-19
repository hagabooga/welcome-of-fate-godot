extends Node

var tol
var player
var player_equipment

var dict_equip = {"accessory":0,"head":1,"neck":2,"weapon":3, "body":4,
"shield":5, "boots":6,"bottom":7,"gloves":8, "tool":3, "wand":3 }

func equip(item):
	var i = dict_equip[item.type.to_lower()]
	#print(item.type)
	if (item.type == "Tool"):
		var split_name = item.ming.split(" ")
		if len(split_name) > 1:
			if split_name[1] == "Seedbag":
				player.find_node("Tool").set_script(load("res://scripts/tools/" + split_name[1].to_lower() + ".gd"))
				player.find_node("Tool").plant_ming = split_name[0]
				player.find_node("Tool").set_color(item.color)
				player_equipment.set_item_icon(i, load("res://sprites/items/%s.png"%item.ming.to_lower()))
				player_equipment.set_item_metadata(i,item)
				return
			else:
				player.find_node("Tool").set_script(load("res://scripts/tools/" + item.ming.to_lower() + ".gd"))
				player_equipment.set_item_icon(i, load("res://sprites/items/%s.png"%item.ming.to_lower()))
				player_equipment.set_item_metadata(i,item)
				return
		player.find_node("Tool").set_script(load("res://scripts/tools/" + item.ming.to_lower() + ".gd"))
		player_equipment.set_item_icon(i, load("res://sprites/items/%s.png"%item.ming.to_lower()))
		player_equipment.set_item_metadata(i,item)
	elif item.type.to_lower() in item_database.weapons:
		#print("wow")
		player_equipment.set_item_icon(i, load("res://sprites/items/%s.png"%item.ming.to_lower()))
		player_equipment.set_item_metadata(i,item)
		print(player_stats.magical)
		player_stats.add_attrib(item.stats)
		print(player_stats.magical)
		
		
