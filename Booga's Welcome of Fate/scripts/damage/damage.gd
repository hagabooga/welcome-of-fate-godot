extends Node

class_name Damage

var damage
var is_crit = false
var hit
var knockback
var hitstun_multi
var stun
var type
var dealer

enum {physical, magical}

func init(dmg, typ, dler, typ, knck = 0, hs_mutli = 1, stn = 0):
	damage = dmg
	knockback = knck
	hitstun_multi = hs_mutli
	stun = stn
	type = typ
	dealer = dler
	type = typ