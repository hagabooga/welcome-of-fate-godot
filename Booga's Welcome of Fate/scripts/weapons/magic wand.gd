extends "res://scripts/player/player_weapon.gd"

var projectile = load("res://scenes/projectiles/MagicShot.tscn")



func attack_effect(facing, flipped_h):
	var proj = projectile.instance()
	world_globals.world.add_child(proj)
	proj.global_position = global_position
	proj.set_velocity(facing, flipped_h)
	proj.damage = proj_damage()

func proj_damage():
	return player_stats.magical * 0.2