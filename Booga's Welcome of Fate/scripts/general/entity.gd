extends Attributes

class_name Entity

var ming
export(int) var move_speed
var can_move
var velocity = Vector2.ZERO

func is_actionable() -> bool:
	return $Hitstun.in_hitstun() || !$Sprite/AnimationPlayer.is_playing()

func is_dead() -> bool:
	return hp > 0
	
func take_damge(dmg : Damage):
	pass

