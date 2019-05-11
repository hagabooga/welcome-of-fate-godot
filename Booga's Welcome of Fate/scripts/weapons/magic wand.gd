extends Weapon

var projectile = load("res://scenes/projectiles/MagicShot.tscn")

func attack_effect():
	var proj = projectile.instance()
	world_globals.world.add_child(proj)
	proj.global_position = global_position
	proj.set_velocity(current_dir)
	proj.damage = proj_damage()

func proj_damage():
	return player_stats.magical * 0.2


