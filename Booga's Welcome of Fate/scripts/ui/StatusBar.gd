extends Panel

func _ready():
	player_stats.connect("hp_change",self, "update_healthBar")
	player_stats.connect("mp_change",self, "update_manaBar")
	player_stats.connect("energy_change",self, "update_energyBar")
	player_stats.connect("stats_change",self, "update_allBars")
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
	$VBoxContainer/EnergyBar.max_value = player_stats.max_energy
	$VBoxContainer/EnergyBar.value = player_stats.energy
	$VBoxContainer/EnergyBar/Label.text = "%s / %s"%[player_stats.energy, player_stats.max_energy]
	$VBoxContainer/EnergyBar.max_value = player_stats.max_energy

func update_allBars():
	update_healthBar()
	update_manaBar()
	update_energyBar()
	
