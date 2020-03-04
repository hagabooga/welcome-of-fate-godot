extends ToolItem

class_name WateringCan

var current_amount : int = 0 setget set_amount
var capacity : int

signal on_set_amount

func set_amount(val):
	current_amount = val
	emit_signal("on_set_amount")
	
func can_pour():
	return true
	return current_amount > 0

func _init(ming : String, data : Dictionary).(ming, data):
	capacity = data.capacity
