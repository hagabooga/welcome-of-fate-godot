extends Panel

func update_healthBar(max_hp , hp):
	$VBoxContainer/HealthBar.max_value = max_hp
	$VBoxContainer/HealthBar.value = hp
	$VBoxContainer/HealthBar/Label.text = "%s / %s"%[hp, max_hp]
	$VBoxContainer/HealthBar.max_value = max_hp

func update_manaBar(max_mp, mp):
	$VBoxContainer/ManaBar.max_value = max_mp
	$VBoxContainer/ManaBar.value = mp
	$VBoxContainer/ManaBar/Label.text = "%s / %s"%[mp, max_mp]
	$VBoxContainer/ManaBar.max_value = max_mp

func update_energyBar(max_energy,energy):
	$VBoxContainer/EnergyBar.max_value = max_energy
	$VBoxContainer/EnergyBar.value = energy
	$VBoxContainer/EnergyBar/Label.text = "%s / %s"%[energy, max_energy]
	$VBoxContainer/EnergyBar.max_value = max_energy
	
func update_xpBar(max_energy,energy):
	$VBoxContainer/EXPBar.max_value = max_energy
	$VBoxContainer/EXPBar.value = energy
	$VBoxContainer/EXPBar/Label.text = "%s / %s"%[energy, max_energy]
	$VBoxContainer/EXPBar.max_value = max_energy

#func update_allBars():
#	update_healthBar()
#	update_manaBar()
#	update_energyBar()
