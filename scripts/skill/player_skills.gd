extends Node

#var learned_skills = []
#
#signal skill_changed
#signal skill_learned(skill)
#
#func _ready():
#	connect("skill_changed",self,"update_skills")
#	update_skills()
#	player_stats.connect("stats_change", self, "update_skills")
#
#func update_skills():
#	for x in learned_skills:
#		match x.ming:
#			"fireball":
#				x.damage = 75 + 25 * x.rank + player_stats.intelligence * (16 + 18*x.rank)
#				x.mana = 100 + x.rank * 50
#				x.cooldown = 1.25
#			"summon fire lion":
#				x.damage = 250
#				x.mana = 150
#				x.cooldown = 2
#			"torrentacle":
#				x.damage = 75
#				x.mana = 100
#				x.cooldown = 3
