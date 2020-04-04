extends PickableWorldObject

func clicked(tewl : Item, user : Attributes):
	if tewl != null and tewl.type == "axe":
		$AnimationPlayer.play("used")
		sound_player.play_sound(63,self, false)
		get_tree().current_scene.generate_item("wooden plank", self)
		return [
#			ClickAction.new(ClickAction.ADD_ITEM, ["wooden plank"]),
			ClickAction.new(ClickAction.GAIN_EXP, [3]),
			ClickAction.new(ClickAction.ADD_SKILL_POINT, ["wood"])]
