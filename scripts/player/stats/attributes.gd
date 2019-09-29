extends KinematicBody2D

class_name Attributes

var stats = []
var strength : int setget set_str,get_str 
var intelligence setget set_int, get_int
var agility setget set_agi, get_agi
var luck setget set_lck, get_lck
var physical setget set_phys, get_phys
var magical setget set_magic, get_magic
var armor setget set_armor, get_armor
var resist setget set_res, get_res
var hit setget set_hit, get_hit
var dodge setget set_dodge, get_dodge
var crit setget set_crit, get_crit
var crit_multi setget set_critmulti, get_critmulti
var atk_spd setget set_atkspd, get_atkspd
var max_hp setget set_maxhp, get_maxhp
var max_mp setget set_maxmp, get_maxmp
var max_energy setget set_energy, get_energy
var energy setget set_eng
var hp setget set_hp, get_hp
var mp setget set_mp
var level = 1
var job = "Attributes: No Name"

signal on_hp_add(value)
signal on_hp_change(max_hp, current_hp)
signal on_mp_change(max_mo, current_mp)
signal on_energy_change(max_energy, current_energy)

func get_hp():
	return hp

func set_hp(val):
	hp = val
	emit_signal("on_hp_change", self.max_hp, hp)
	
func set_mp(val):
	mp = val
	emit_signal("on_mp_change", self.max_mp, mp)
	
func set_eng(val):
	energy = val
	emit_signal("on_energy_change", self.max_energy, energy)
	
func set_str(val):
	find_stat(0).base = val
func set_int(val):
	find_stat(1).base = val
func set_agi(val):
	find_stat(2).base = val
func set_lck(val):
	find_stat(3).base = val
func set_phys(val):
	find_stat(4).base = val
func set_magic(val):
	find_stat(5).base = val
func set_armor(val):
	find_stat(6).base = val
func set_res(val):
	find_stat(7).base = val
func set_hit(val):
	find_stat(8).base = val
func set_dodge(val):
	find_stat(9).base = val
func set_crit(val):
	find_stat(10).base = val
func set_critmulti(val):
	find_stat(11).base = val
func set_atkspd(val):
	find_stat(12).base = val
func set_maxhp(val):
	find_stat(13).base = val
	emit_signal("on_hp_change", self.max_hp, hp)
func set_maxmp(val):
	find_stat(14).base = val
	emit_signal("on_mp_change", self.max_mp, mp)
func set_energy(val):
	find_stat(15).base = val
	emit_signal("on_energy_change", self.max_energy, energy)
	
func get_str():
	return find_stat(0).get_final_value()
func get_int():
	return find_stat(1).get_final_value()
func get_agi():
	return find_stat(2).get_final_value()
func get_lck():
	return find_stat(3).get_final_value()
func get_phys():
	return find_stat(4).get_final_value()
func get_magic():
	return find_stat(5).get_final_value()
func get_armor():
	return find_stat(6).get_final_value()
func get_res():
	return find_stat(7).get_final_value()
func get_hit():
	return find_stat(8).get_final_value()
func get_dodge():
	return find_stat(9).get_final_value()
func get_crit():
	return find_stat(10).get_final_value()
func get_critmulti():
	return find_stat(11).get_final_value()
func get_atkspd():
	return find_stat(12).get_final_value()
func get_maxhp():
	return find_stat(13).get_final_value()
func get_maxmp():
	return find_stat(14).get_final_value()
func get_energy():
	return find_stat(15).get_final_value()

func _init():
	for x in range(16):
		stats.append(BaseStat.new(x))
	hp = 0
	mp = 0
	energy = 0

func find_stat(type):
	for x in stats:
		if x.type == type:
			return x

func add_hp(val):
	self.hp += val
	if self.hp > self.max_hp:
		self.hp = self.max_hp
	emit_signal("on_hp_add", val)
	emit_signal("on_hp_change", self.max_hp, hp)

func add_mp(val):
	self.mp += val
	if self.mp > self.max_mp:
		self.mp = self.max_mp
	emit_signal("on_mp_change", self.max_mp, mp)

func add_energy(val):
	self.energy += val
	if self.energy > self.max_energy:
		self.energy = self.max_energy
	emit_signal("on_energy_change", self.max_energy, energy)

func set_stat(type, val):
	find_stat(type).base = val
	update_stats()

func buff_stat(type, val):
	find_stat(type).buff(val)
	update_stats()

func remove_buff_stat(type, val):
	find_stat(type).remove_buff(val)
	update_stats()

func add_attrib(a):
	for x in stats:
		for y in a.stats:
			if x.type == y.type and y.final_val != 0:
				buff_stat(x.type, y.final_val)
				break
	update_stats()
				
func remove_attrib(a):
	for x in stats:
		for y in a.stats:
			if x.type == y.type and y.final_val != 0:
				remove_buff_stat(x.type, y.final_val)
				break
	update_stats()
				
func update_stats():
	pass

func print_stats():
	for x in stats:
		print("%s: %d"%[global_id.stat_idToName[x.type],x.final_val])
		
func print_stats_bonuses():
	for x in stats:
		print("%s: %s"%[global_id.stat_idToName[x.type],x.bonuses])