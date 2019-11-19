extends ToolItem

class_name WateringCan

var current_amount : int = 0 setget set_amount
var capacity : int

signal on_set_amount

func set_amount(val):
	print(current_amount)
	current_amount = val
	print(current_amount)
	emit_signal("on_set_amount")
	
func can_pour():
	return current_amount > 0

func _init(m, d, ef, c, b, t, a, col, e=5, cap = 10).(m, d, ef, c, b, t, a, col, e):
	base = b
	capacity = cap