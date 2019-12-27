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
var max_xp setget set_max_xp, get_max_xp

var energy setget set_eng
var hp setget set_hp, get_hp
var mp setget set_mp
var level : int = 1
var ap : int = 0 setget set_ap
var max_ap : int = 0

func set_ap(val):
	ap = val
func add_ap(val : int):
	ap += val
	max_ap += val
	emit_signal("on_ap_change")
	
var job = "Attributes Job: No Name"

var xp setget set_xp,get_xp


signal on_hp_add(value, color_pos, color_neg)
signal on_mp_add(value, color_pos, color_neg)
signal on_energy_add(value, color_pos, color_neg)
signal on_xp_add(value, color_pos, color_neg)

signal on_hp_change(max_hp, current_hp)
signal on_mp_change(max_mo, current_mp)
signal on_energy_change(max_energy, current_energy)
signal on_xp_change(max_xp, current_xp)
signal on_ap_change


signal stat_changed


func set_xp(val):
	xp = val
	emit_signal("on_xp_change", self.max_xp, xp, self.level)

func get_xp():
	return xp


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
	update_stats()
func set_int(val):
	find_stat(1).base = val
	update_stats()
func set_agi(val):
	find_stat(2).base = val
	update_stats()
func set_lck(val):
	find_stat(3).base = val
	update_stats()
func set_phys(val):
	find_stat(4).base = val
	emit_signal("stat_changed")
func set_magic(val):
	find_stat(5).base = val
	emit_signal("stat_changed")
func set_armor(val):
	find_stat(6).base = val
	emit_signal("stat_changed")
func set_res(val):
	find_stat(7).base = val
	emit_signal("stat_changed")
func set_hit(val):
	find_stat(8).base = val
	emit_signal("stat_changed")
func set_dodge(val):
	find_stat(9).base = val
	emit_signal("stat_changed")
func set_crit(val):
	find_stat(10).base = val
	emit_signal("stat_changed")
func set_critmulti(val):
	find_stat(11).base = val
	emit_signal("stat_changed")
func set_atkspd(val):
	find_stat(12).base = val
	emit_signal("stat_changed")
func set_maxhp(val):
	find_stat(13).base = val
	emit_signal("stat_changed")
	emit_signal("on_hp_change", self.max_hp, hp)
func set_maxmp(val):
	find_stat(14).base = val
	emit_signal("stat_changed")
	emit_signal("on_mp_change", self.max_mp, mp)
func set_energy(val):
	find_stat(15).base = val
	emit_signal("stat_changed")
	emit_signal("on_energy_change", self.max_energy, energy)
func set_max_xp(val):
	find_stat(16).base = val
	emit_signal("stat_changed")
	emit_signal("on_xp_change", self.max_xp, xp, self.level)
	
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
func get_max_xp():
	return find_stat(16).get_final_value()

func _init():
	for x in range(17):
		stats.append(BaseStat.new(x))
	hp = 0
	mp = 0
	energy = 0

func find_stat(type) -> BaseStat:
	for x in stats:
		if x.type == type:
			return x
	print("DID NOT FIND STAT!!!!!!!!!!!!")
	return null

func add_hp(val):
	self.hp += val
	if self.hp > self.max_hp:
		self.hp = self.max_hp
	elif self.hp < 0:
		self.hp = 0
	emit_signal("on_hp_add", val, Color.green, Color.red)
	emit_signal("on_hp_change", self.max_hp, hp)

func add_mp(val):
	self.mp += val
	if self.mp > self.max_mp:
		self.mp = self.max_mp
	emit_signal("on_mp_add", val, Color.aqua, Color.purple)
	emit_signal("on_mp_change", self.max_mp, mp)

func add_energy(val):
	self.energy += val
	if self.energy > self.max_energy:
		self.energy = self.max_energy
	emit_signal("on_energy_add", val, Color.orange, Color.darkolivegreen)
	emit_signal("on_energy_change", self.max_energy, energy)

func add_xp(val):
	var leftover = val - self.max_xp + self.xp
	self.xp += val
	if self.xp >= self.max_xp:
		level_up()
		if leftover > 0:
			add_xp(leftover)
	emit_signal("on_xp_add", val, Color.yellow, Color.darkolivegreen)
	emit_signal("on_xp_change", self.max_xp, self.xp, self.level)

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

func level_up():
	self.xp = 0
	level += 1
	add_ap(5)
	update_stats()
	full_hp()
	full_mp()
	full_energy()
	print_stats()
	
	
func full_hp():
	self.hp = self.max_hp

func full_mp():
	self.mp = self.max_mp
	
func full_energy():
	self.energy = self.max_energy

func print_stats():
	print("level: %d"%level)
	for x in stats:
		print("%s: %d"%[global_id.stat_idToName[x.type],x.final_val])
		
func print_stats_bonuses():
	for x in stats:
		print("%s: %s"%[global_id.stat_idToName[x.type],x.bonuses])