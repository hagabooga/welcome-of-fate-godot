extends Node

var damage_popup = load("res://scenes/general/DamagePopup.tscn")

func make_damage_popup():
	return damage_popup.instance()
	