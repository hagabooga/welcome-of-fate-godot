extends Weapon

func get_damage() -> Damage:
	return Damage.new(self, 2)
	