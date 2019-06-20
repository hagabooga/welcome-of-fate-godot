extends Node

var player


func activate_skill(s):
	match s.ming:
		"fireball":
			proj_skill(s)
		"summon fire lion":
			proj_skill(s)
			
			

func proj_skill(s):
	print(s)
	var proj = player.create_projectile(load("res://scenes/projectiles/%s.tscn"%s.ming))
	proj.set_velocity(player.facing)
	print(player.facing)
	proj.damage = s.damage