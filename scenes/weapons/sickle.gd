extends Weapon

func get_damage() -> Damage:
	return Damage.new(owner,15)