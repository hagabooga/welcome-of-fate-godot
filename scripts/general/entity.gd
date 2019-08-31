extends Attributes

class_name Entity

var damage_popup = load("res://scenes/general/DamagePopup.tscn")


var ming = "Entity No Name"
export(int) var move_speed
var can_move : bool = true
var velocity = Vector2.ZERO

func _process(delta):
	change_z_index_relative_to_tilemap()

func change_z_index_relative_to_tilemap() -> void:
	var z = owner.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = owner.tilemap_soil.world_to_map(global_position).y


func is_actionable() -> bool:
	return $Hitstun.in_hitstun() || !$Sprite/AnimationPlayer.is_playing()

func is_dead() -> bool:
	return hp > 0
	
func take_damage(dmg : Damage) -> void:
	#print(dmg.dealer.name,dmg.damage)
	hp -= dmg.damage
	var dmgpop = damage_popup.instance()
	dmgpop.set_text_and_play(dmg.damage)
	add_child(dmgpop)

func update_stats() -> void:
	pass