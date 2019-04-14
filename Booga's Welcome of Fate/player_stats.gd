extends "res://mage.gd"
#var stats = load("res://mage.gd").new()

signal hp_change
signal mp_change
signal energy_change

func _init():
	level = 1
	update_stats()
	self.hp = self.max_hp
	self.mp = self.max_mp
	self.energy = self.max_energy



func can_use(e):
	if (self.energy >= e):
		self.energy -= e
		return true
	return false






func set_hp_extra():
	emit_signal("hp_change")
func set_mp_extra():
	emit_signal("mp_change")
func set_energy_extra():
	emit_signal("energy_change")
	