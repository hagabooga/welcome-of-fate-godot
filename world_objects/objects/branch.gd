extends PickableWorldObject

func clicked(tewl : Item, user : Attributes):
	if tewl != null and tewl.type == "axe":
		$AnimationPlayer.play("used")
		sound_player.play_sound(58,self, false)
		return [ClickAction.new(ClickAction.ADD_ITEM, ["wooden plank"]),
		ClickAction.new(ClickAction.GAIN_EXP, [3])]