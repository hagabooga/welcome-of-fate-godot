extends PickableWorldObject

func clicked(tewl: Item):
	if tewl != null and tewl.type == "sickle":
		$AnimationPlayer.play("used")