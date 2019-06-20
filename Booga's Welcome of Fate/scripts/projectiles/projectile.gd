extends KinematicBody2D

class_name Projectile
enum {up,left,down,right}
var velocity = Vector2.ZERO
export(int) var speed = 20
export(float) var travel_time = 1
var damage
export(int) var pierce = 1
var targets_hit = []

func _physics_process(delta):
	move_and_slide(velocity.normalized() * speed)
	
func set_velocity(facing):
	$AnimationPlayer.play("start")
	$AnimationPlayer.playback_speed = $AnimationPlayer.current_animation_length/travel_time
	if facing == up:
		velocity = Vector2(0,-1)
		rotate(-PI/2)
	elif facing == left:
		velocity = Vector2(-1,0)
		rotate(-PI)
		$Sprite.flip_v = true
		$Hitbox.scale.y = -1
	elif facing == right:
		velocity = Vector2(1,0)
		$Sprite.flip_h = false
		$Hitbox.scale.y = 1
	else:
		velocity = Vector2(0,1)
		rotate(PI/2)

func _on_Hitbox_area_entered(area):
	var area_par = area.get_parent()
	if area_par is Enemy:
		targets_hit.append(area)
		if len(targets_hit) == pierce:
			queue_free()
		area_par.take_damage(damage)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
