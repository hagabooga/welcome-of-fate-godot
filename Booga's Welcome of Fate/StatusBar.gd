extends Panel

func _ready():
	player_stats.connect("hp_change",self, "update_healthBar")
	player_stats.connect("mp_change",self, "update_manaBar")
	player_stats.connect("energy_change",self, "update_energyBar")
	update_allBars()

func update_healthBar():
	$VBoxContainer/HealthBar.max_value = player_stats.max_hp
	$VBoxContainer/HealthBar.value = player_stats.hp
	$VBoxContainer/HealthBar/Label.text = "%s / %s"%[player_stats.hp, player_stats.max_hp]
	$VBoxContainer/HealthBar.max_value = player_stats.max_hp

func update_manaBar():
	$VBoxContainer/ManaBar.max_value = player_stats.max_mp
	$VBoxContainer/ManaBar.value = player_stats.mp
	$VBoxContainer/ManaBar/Label.text = "%s / %s"%[player_stats.mp, player_stats.max_mp]
	$VBoxContainer/ManaBar.max_value = player_stats.max_mp
	
func update_energyBar():
	print("LOL")
	$VBoxContainer/EnergyBar.max_value = player_stats.max_energy
	$VBoxContainer/EnergyBar.value = player_stats.energy
	$VBoxContainer/EnergyBar/Label.text = "%s / %s"%[player_stats.energy, player_stats.max_energy]
	$VBoxContainer/EnergyBar.max_value = player_stats.max_energy

func update_allBars():
	update_healthBar()
	update_manaBar()
	update_energyBar()
	
func _on_HealthBar_changed():
	update_healthBar()

func _on_HealthBar_value_changed(value):
	update_healthBar()


func _on_ManaBar_changed():
	update_manaBar()


func _on_ManaBar_value_changed(value):
	update_manaBar()


func _on_EnergyBar_changed():
	update_energyBar()


func _on_EnergyBar_value_changed(value):
	update_energyBar()
