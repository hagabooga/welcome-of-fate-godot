extends Node

var base_stat = load("res://base_stat.gd")

var stats = []

var strength setget set_str,get_str
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
var hp setget set_hp
var mp setget set_mp
var level
var job

func set_hp_extra():
	pass 
func set_mp_extra():
	pass
func set_energy_extra():
	pass

func set_hp(val):
	hp = val
	set_hp_extra()
	
func set_mp(val):
	mp = val
	set_mp_extra()
	
func set_eng(val):
	energy = val
	set_energy_extra()
	
func set_str(val):
	find_stat(global_enums.stren).value = val
func set_int(val):
	find_stat(global_enums.intel).value = val
func set_agi(val):
	find_stat(global_enums.agi).value = val
func set_lck(val):
	find_stat(global_enums.lck).value = val
func set_phys(val):
	find_stat(global_enums.phys).value = val
func set_magic(val):
	find_stat(global_enums.magic).value = val
func set_armor(val):
	find_stat(global_enums.arm).value = val
func set_res(val):
	find_stat(global_enums.res).value = val
func set_hit(val):
	find_stat(global_enums.hi).value = val
func set_dodge(val):
	find_stat(global_enums.dge).value = val
func set_crit(val):
	find_stat(global_enums.crt).value = val
func set_critmulti(val):
	find_stat(global_enums.critmulti).value = val
func set_atkspd(val):
	find_stat(global_enums.atkspd).value = val
func set_maxhp(val):
	find_stat(global_enums.maxhp).value = val
func set_maxmp(val):
	find_stat(global_enums.maxmp).value = val
func set_energy(val):
	find_stat(global_enums.energy).value = val
	
func get_str():
	return find_stat(global_enums.stren).get_final_value()
func get_int():
	return find_stat(global_enums.intel).get_final_value()
func get_agi():
	return find_stat(global_enums.agi).get_final_value()
func get_lck():
	return find_stat(global_enums.lck).get_final_value()
func get_phys():
	return find_stat(global_enums.phys).get_final_value()
func get_magic():
	return find_stat(global_enums.magic).get_final_value()
func get_armor():
	return find_stat(global_enums.arm).get_final_value()
func get_res():
	return find_stat(global_enums.res).get_final_value()
func get_hit():
	return find_stat(global_enums.hi).get_final_value()
func get_dodge():
	return find_stat(global_enums.dge).get_final_value()
func get_crit():
	return find_stat(global_enums.crt).get_final_value()
func get_critmulti():
	return find_stat(global_enums.critmulti).get_final_value()
func get_atkspd():
	return find_stat(global_enums.atkspd).get_final_value()
func get_maxhp():
	return find_stat(global_enums.maxhp).get_final_value()
func get_maxmp():
	return find_stat(global_enums.maxmp).get_final_value()
func get_energy():
	return find_stat(global_enums.energy).get_final_value()

func _init():
	for x in range(16):
		stats.append(base_stat.new(x))

func find_stat(type):
	for x in stats:
		if x.type == type:
			return x

func buff_stat(type, val):
	find_stat(type).buff(val)

func remove_buff_stat(type, val):
	find_stat(type).remove_buff_stat(val)

func update_stats():
	pass