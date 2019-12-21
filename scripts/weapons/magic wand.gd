extends Weapon

var projectile = load("res://scenes/projectiles/MagicShot.tscn")

func get_damage() -> Damage:
	return Damage.new(owner,20)


func attack_effect(angle) -> void:
	#var player : Entity = owner
	var proj = projectile.instance()
	get_tree().get_root().add_child(proj)
	proj.global_position = global_position
	proj.damage = get_damage()
	proj.set_velocity(angle)
	

func proj_damage():
	return  0.3


