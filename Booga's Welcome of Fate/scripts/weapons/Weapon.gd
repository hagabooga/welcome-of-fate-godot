extends SpriteWithBodyAnimation

class_name Weapon

var damage setget ,get_damage
var targets_hit = []

func _ready():
	$Hitbox/CollisionShape2D.disabled = true

func _process(delta):
	update()

func _draw():
	var col = Color.red
	if !$Hitbox/CollisionShape2D.disabled:
		col.a = 0.5
		draw_circle($Hitbox.position, $Hitbox/CollisionShape2D.shape.radius, col)

func get_damage():
	return player_stats.physical
	
func attack_effect():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	$Hitbox/CollisionShape2D.disabled = true

func _on_AnimationPlayer_animation_started(anim_name):
	$Hitbox/CollisionShape2D.disabled = false
