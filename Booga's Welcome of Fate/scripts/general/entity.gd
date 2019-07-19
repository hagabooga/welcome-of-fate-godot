extends Attributes

class_name Entity

var ming = "Entity No Name"
export(int) var move_speed = 100
var can_move
var velocity = Vector2.ZERO

func _process(delta):
	change_z_index_relative_to_tilemap()

func change_z_index_relative_to_tilemap() -> void:
	pass
	#var z = owner.tilemap_soil.world_to_map(global_position).y
	#if z >= 0:
		#z_index = owner.tilemap_soil.world_to_map(global_position).y


func is_actionable() -> bool:
	return $Hitstun.in_hitstun() || !$Sprite/AnimationPlayer.is_playing()

func is_dead() -> bool:
	return hp > 0
	
func take_damage(dmg : Damage):
	pass

