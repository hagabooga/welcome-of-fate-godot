extends Weapon

var projectile = load("res://scenes/projectiles/MagicShot.tscn")

func get_damage() -> Damage:
	return Damage.new(owner,69)


func attack_effect():
	var player : Entity = owner
	var proj = world_globals.player.create_projectile(projectile)
	#proj.set_velocity(current_dir)
	proj.damage = proj_damage()

func proj_damage():
	return  0.3


