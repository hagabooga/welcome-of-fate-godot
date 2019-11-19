extends PickableWorldObject

func clicked(tewl : Item, user : Entity):
	if tewl != null and tewl.type == "axe":
		$AnimationPlayer.play("used")
		user.use_energy(tewl.energy_cost)
		return ClickAction.new(ADD_ITEM, ["wooden plank"])
		