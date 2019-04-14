extends Node

var base_stat = load("res://base_stat.gd")

var stats = []

var strength setget set_str
var intelligence setget set_int
var agility setget set_agi
var luck setget set_lck
var physical setget set_phys
var magical setget set_magic
var armor setget set_armor
var resist setget set_res
var hit setget set_hit
var dodge setget set_dodge
var crit setget set_crit
var crit_multi setget set_critmulti
var atk_spd setget set_atkspd
var max_hp setget set_maxhp
var max_mp setget set_maxmp
var hp
var mp
var level
var job

func set_str(val):
	strength = val
func set_int(val):
	intelligence = val
func set_agi(val):
	agility = val
func set_lck(val):
	luck = val
func set_phys(val):
	physical = val
func set_magic(val):
	magical = val
func set_armor(val):
	armor = val
func set_res(val):
	resist = val
func set_hit(val):
	hit = val
func set_dodge(val):
	dodge = val
func set_crit(val):
	crit = val
func set_critmulti(val):
	crit_multi = val
func set_atkspd(val):
	atk_spd = val
func set_maxhp(val):
	max_hp = val
func set_maxmp(val):
	max_mp = val

func _init():
	for x in range(15):
		stats.append(base_stat.new(x))

func find_stat(type):
	for x in stats:
		if x.type == type:
			return x

func buff_stat(type, val):
	find_stat(type).buff(val)

func remove_buff_stat(type, val):
	find_stat(type).remove_buff_stat(val)

func add_hp(x):
	hp += x
func add_mp(x):
	mp += x

func update_stats():
	pass