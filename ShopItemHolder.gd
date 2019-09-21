extends ItemHolderBase

func _ready():
	can_swap = false
	cost_money_drop = true

func get_drag_data(position):
	return self
