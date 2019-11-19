extends PickableWorldObject

func clicked(tewl: Item, user : Entity):
	if tewl != null and tewl.type == "sickle":
		.clicked(tewl, user)
		$AnimationPlayer.play("used")