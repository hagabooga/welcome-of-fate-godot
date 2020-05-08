extends WorldObject


var drops = {
	"scrap" : 70,
	"stone": 50,
	"iron": 40
}


func clicked(tewl : Item, user : Attributes):
	if tewl != null and tewl.type == "hammer":
#		$AnimationPlayer.play("used")
		sound_player.play_sound(59,self, false)
		var chosen_drop = drops.keys()[randi()%len(drops)]
		if randi()%100 <= drops[chosen_drop]:
			get_tree().current_scene.generate_item(chosen_drop, self)
		destroy_and_remove_from_map()
		return [
			ClickAction.new(ClickAction.GAIN_EXP, [4])
		]
