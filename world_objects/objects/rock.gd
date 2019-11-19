extends PickableWorldObject

func clicked(tewl : Item, user : Entity):
	if tewl != null and tewl.type == "hammer":
		$AnimationPlayer.play("used")
		user.use_energy(tewl.energy_cost)
		return ClickAction.new(ADD_ITEM, ["stone"])