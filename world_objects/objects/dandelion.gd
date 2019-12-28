extends PickableWorldObject

func clicked(tewl: Item, user : Entity):
	if tewl != null and tewl.type == "sickle":
		.clicked(tewl, user)
		$AnimationPlayer.play("used")
		sound_player.play_sound(18,self,false)
		return [ClickAction.new()]