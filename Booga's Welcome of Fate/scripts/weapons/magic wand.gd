extends Weapon

var projectile = load("res://scenes/projectiles/summon fire lion.tscn")

func attack_effect():
	var proj = world_globals.player.create_projectile(projectile)
	proj.set_velocity(current_dir)
	proj.damage = proj_damage()

func proj_damage():
	return player_stats.magical * 0.3


