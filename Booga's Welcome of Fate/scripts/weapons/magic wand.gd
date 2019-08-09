extends Weapon

var projectile = load("res://scenes/projectiles/MagicShot.tscn")

func get_damage() -> Damage:
	return Damage.new(owner,69)


func attack_effect(facing) -> void:
	var player : Entity = owner
	var proj = projectile.instance()
	get_tree().get_root().add_child(proj)
	proj.global_position = player.global_position
	proj.damage = get_damage()
	proj.set_velocity(facing)
	

func proj_damage():
	return  0.3


