extends Node

var player

func _ready():
	player = 

func activate_skill(s):
	match s.ming:
		"fireball":
			proj_skill(s)
			
			

func proj_skill(s):
	print(s)
	var proj = player.create_projectile(load("res://scenes/projectiles/%s.tscn"%s.ming))
	proj.set_velocity(player.facing)
	proj.damage = s.damage