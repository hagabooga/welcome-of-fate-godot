extends SpriteWithBodyAnimation

class_name Weapon

var damage : Damage setget ,get_damage
var targets_hit = []
var pierce = 1

func _ready():
	$Hitbox/CollisionShape2D.disabled = true

func get_damage() -> Damage:
	return null
	
func attack_effect(a):
	pass

func _on_Hitbox_area_entered(area):
#	if area.name == "Hurtbox":
	var area_par = area.get_parent()
	if area_par is Enemy and not area_par in targets_hit and pierce > len(targets_hit):
		area_par.take_damage(self.damage)
		targets_hit.append(area_par)

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name.substr(0,4) == "slas":
		$Hitbox/CollisionShape2D.disabled = false
		targets_hit.clear()
	else:
		$Hitbox/CollisionShape2D.disabled = true

func _on_Hitbox_body_entered(body):
	if body is Entity:
		body.take_damage(self.damage)
