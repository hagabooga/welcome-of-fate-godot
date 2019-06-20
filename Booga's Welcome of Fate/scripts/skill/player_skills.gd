extends Node

var learned_skills = []

signal skill_changed
signal skill_learned(skill)

func _ready():
	connect("skill_changed",self,"update_skills")
	update_skills()

func update_skills():
	for x in learned_skills:
		match x.ming:
			"fireball":
				x.damage = 75 + 25 * x.rank + player_stats.intelligence * (16 + 18*x.rank)
				x.mana = 50
				x.cooldown = 3
			"summon fire lion":
				x.damage = 250
				x.mana = 150
				x.cooldown = 6