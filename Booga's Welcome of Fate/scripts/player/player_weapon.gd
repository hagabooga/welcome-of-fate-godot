extends Node2D

var damage setget ,get_damage
var targets_hit = []

func _ready():
	$Hitbox/CollisionShape2D.disabled = true

#func _process(delta):
#	update()
#
#func _draw():
#	var col = Color.red
#	if !$Hitbox/CollisionShape2D.disabled:
#		col.a = 0.5
#		draw_circle($Hitbox.position, $Hitbox/CollisionShape2D.shape.radius, col)


func get_damage():
	print("base player_weapon get_damage() called")
	return player_stats.physical
	
func reset():
	$AnimationPlayer.stop()

func play_anim(anim, speed):
	$AnimationPlayer.playback_speed = speed
	$AnimationPlayer.play(anim)
	targets_hit = []
	
	

func attack_effect(facing, flipped_h):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if $AnimationPlayer.assigned_animation != "idle":
		$AnimationPlayer.play("idle")
		$Hitbox/CollisionShape2D.disabled = true
		

func _on_AnimationPlayer_animation_started(anim_name):
	$Hitbox/CollisionShape2D.disabled = false


func _on_Hitbox_area_entered(area):
	if area.name == "Hurtbox":
		var area_par = area.get_parent()
		if not area_par in targets_hit and area_par is Enemy:
			area_par.take_damage(self.damage)
			targets_hit.append(area_par)
