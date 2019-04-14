extends Node

func activate(i):
	match i:
		"Turnip":
			print(player_stats.stats.hp)
			player_stats.stats.hp += 30
			print("Now: " + str(player_stats.stats.hp))