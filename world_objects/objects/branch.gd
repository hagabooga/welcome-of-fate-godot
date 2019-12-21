extends PickableWorldObject

func clicked(tewl : Item, user : Entity):
	if tewl != null and tewl.type == "axe":
		$AnimationPlayer.play("used")
		return ClickAction.new(ADD_ITEM, ["wooden plank"])
		