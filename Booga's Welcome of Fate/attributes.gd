extends Node

class_name Attributes


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
	find_stat(0).value = val
func set_int(val):
	find_stat(1).value = val
func set_agi(val):
	find_stat(2).value = val
func set_lck(val):
	find_stat(3).value = val
func set_phys(val):
	find_stat(4).value = val
func set_magic(val):
	find_stat(5).value = val
func set_armor(val):
	find_stat(6).value = val
func set_res(val):
	find_stat(7).value = val
func set_hit(val):
	find_stat(8).value = val
func set_dodge(val):
	find_stat(9).value = val
func set_crit(val):
	find_stat(10).value = val
func set_critmulti(val):
	find_stat(11).value = val
func set_atkspd(val):
	find_stat(12).value = val
func set_maxhp(val):
	find_stat(13).value = val
func set_maxmp(val):
	find_stat(14).value = val
func set_energy(val):
	find_stat(15).value = val
	
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

func find_stat(type):
	for x in stats:
		if x.type == type:
			return x
			
func set_stat(type, val):
	find_stat(type).value = val

func buff_stat(type, val):
	find_stat(type).buff(val)

func remove_buff_stat(type, val):
	find_stat(type).remove_buff(val)

func add_attrib(a):
	for x in stats:
		for y in a.stats:
			if x.type == y.type and y.value != 0:
				buff_stat(x.type, y.value)
				#print(x.bonuses)
				break
				
func remove_attrib(a):
	for x in stats:
		for y in a.stats:
			if x.type == y.type and y.value != 0:
				remove_buff_stat(x.type, y.value)
				#print(x.bonuses)
				break
				
func update_stats():
	pass

func print_stats():
	for x in stats:
		print("%s: %d"%[global_id.stat_idToName[x.type],x.value])
func print_stats_bonuses():
	for x in stats:
		print("%s: %s"%[global_id.stat_idToName[x.type],x.bonuses])