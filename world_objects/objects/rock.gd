extends PickableWorldObject

func clicked(tewl : Item):
	if tewl != null and tewl.type == "hammer":
		$AnimationPlayer.play("used")
		return ClickAction.new(ADD_ITEM, ["stone"])