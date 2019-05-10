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
#func _process(delta):
#	update()
#
#func _draw():
#	var col = Color.red
#	if !$Hitbox/CollisionShape2D.disabled:
#		col.a = 0.5
#		draw_circle($Hitbox.position, $Hitbox/CollisionShape2D.shape.radius, col)

