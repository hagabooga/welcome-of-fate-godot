extends WorldObject

func clicked(tewl : Item, user : Attributes):
	if tewl.type == "watering can" and tewl.current_amount != tewl.capacity:
		tewl.current_amount = tewl.capacity
		user.use_energy(tewl.energy_cost)
		user.water_can_filled()
		sound_player.play_sound(61,self)
		return [ClickAction.new()]
