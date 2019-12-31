extends PickableWorldObject

func clicked(tewl : Item, user : Attributes):
	if tewl != null and tewl.type == "hammer":
		$AnimationPlayer.play("used")
		sound_player.play_sound(59,self, false)
		return [ClickAction.new(ClickAction.ADD_ITEM, ["stone"]), 
		ClickAction.new(ClickAction.GAIN_EXP, [3])
		]