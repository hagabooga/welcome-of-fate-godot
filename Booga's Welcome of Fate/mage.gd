extends "res://attributes.gd"

func _init():
	job = "Mage"
	strength = 3
	intelligence = 8
	agility = 4
	luck = 5
	crit_multi = 225
	
func update_stats():
	max_hp = 225 + strength * 28 + level * (32 + level)
	max_mp = 475 + intelligence * (35 + level) + level * (55 * level)
	physical = 35 + strength + level * 3
	magical = 70 + intelligence * 8 + level * 9
	
	armor = 15 + strength * 4 + agility * 2
	resist = 25 + intelligence * 5
	
	hit = 90 + int(agility / 6 + luck / 5)
	dodge = 1 + int(agility / 4 + luck / 6)
	crit = 2 + int(agility / 6 + luck / 6); 