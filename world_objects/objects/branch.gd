extends PickableWorldObject

func clicked(tewl : Item, user : Entity):
	if tewl != null and tewl.type == "axe":
		$AnimationPlayer.play("used")
		sound_player.play_sound(58,self, false)
		return ClickAction.new(ADD_ITEM, ["wooden plank"])