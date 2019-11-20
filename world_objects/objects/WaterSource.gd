extends WorldObject

func clicked(tewl : Item, user : Entity):
	if tewl.type == "watering can" and tewl.current_amount != tewl.capacity:
		tewl.current_amount = tewl.capacity
		user.use_energy(tewl.energy_cost)
		user.water_can_filled()