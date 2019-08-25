extends SpriteWithBodyAnimation

class_name Tool

var energy_cost = 0
var tool_anim = "slash"

func use(pos : Vector2):
	pass
	
func show_body_anim(yes):
	self_modulate.a = 0
	if yes:
		self_modulate.a = 1 