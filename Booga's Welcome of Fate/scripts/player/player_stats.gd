extends Mage
#var stats = load("res://mage.gd").new()

signal on_add_hp(val)
signal hp_change
signal mp_change
signal energy_change
signal stats_change

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

func update_stats():
	.update_stats()
	add_hp(0)
	add_mp(0)
	add_energy(0)
	emit_signal("stats_change")

func add_hp(val):
	.add_hp(val)
	print("player took ", val)
	if self.hp <= 0:
		print("PLAYER HAS DIED RESETTING HP...")
		self.hp = self.max_hp
	emit_signal("on_add_hp", val)

func set_hp_extra():
	emit_signal("hp_change")
	
func set_mp_extra():
	emit_signal("mp_change")
	
func set_energy_extra():
	emit_signal("energy_change")
	