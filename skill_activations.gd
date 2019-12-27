extends Node

var player


func activate_skill(s, enemy):
	var data = skill_database.skill_database
	for x in data.keys():
		if x == s.ming:
			var style = data[x].style
			match int(style):
				0: 
					proj_skill(s)
				1: 
					if enemy != null:
						target_skill(s, enemy)

func target_skill(s, enemy):
	
	var skill = load("res://scenes/skills/%s.tscn"%s.ming).instance()
	world_globals.world.add_child(skill)
	skill.activate_on_enemy(s, enemy)
	
func proj_skill(s):
	var proj = player.create_projectile(load("res://scenes/projectiles/%s.tscn"%s.ming))
	proj.set_velocity(player.facing)
	proj.damage = s.damage