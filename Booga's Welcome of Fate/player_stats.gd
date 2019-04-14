extends Node

var stats = load("res://mage.gd").new()

func _init():
	stats.level = 1
	stats.update_stats()
	stats.hp = stats.max_hp
	print(stats.strength)