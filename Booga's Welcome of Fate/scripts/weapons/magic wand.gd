extends "res://scripts/player/player_weapon.gd"

var projectile = load("res://MagicShot.tscn")

func attack_effect(facing, flipped_h):
	var proj = projectile.instance()
	world_globals.world.add_child(proj)
	proj.global_position = global_position
	proj.set_velocity(facing, flipped_h)
	proj.damage = calc_damage()

func calc_damage():
	print(player_stats.magical)
	return player_stats.magical * 0.2