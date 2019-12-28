extends PickableWorldObject

func clicked(tewl : Item, user : Attributes):
	if tewl != null and tewl.type == "hammer":
		$AnimationPlayer.play("used")
		return [ClickAction.new(ClickAction.ADD_ITEM, ["stone"]), 
		ClickAction.new(ClickAction.GAIN_EXP, [3])
		]