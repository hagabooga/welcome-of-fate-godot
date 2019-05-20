extends Node

var damage
var is_crit = false
var hit
var knockback
var stun
var type

enum {physical, magical}

func init(dmg, typ, knck = 0, stn = 0):
	damage = dmg
	knockback = knck
	stun = stn
	type = typ