extends PickableWorldObject

func clicked(tewl : Item):
	if tewl.type == "axe":
		$AnimationPlayer.play("used")