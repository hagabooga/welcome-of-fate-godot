extends KinematicBody2D

class_name Projectile

enum {up,down,left,right}

var velocity : Vector2 = Vector2.ZERO

export(int) var speed : int = 20
export(float) var travel_time : float = 1
var damage : Damage
export(int) var pierce : int = 1
var targets_hit = []

func _physics_process(delta):
	move_and_slide(velocity.normalized() * speed)
	
func _process(delta):
	pass
	
func set_velocity(facing):
	$AnimationPlayer.play("start")
	$AnimationPlayer.playback_speed = $AnimationPlayer.current_animation_length/travel_time
	if facing == up:
		velocity = Vector2(0,-1)
		rotate(-PI/2)
	elif facing == left:
		velocity = Vector2(-1,0)
		$Sprite.flip_h = true
		$Hitbox.scale.x = -1
	elif facing == right:
		velocity = Vector2(1,0)
		$Sprite.flip_h = false
		$Hitbox.scale.x = 1
	else:
		velocity = Vector2(0,1)
		rotate(PI/2)

func _on_Hitbox_body_entered(body):
	if body is Entity:
		body.take_damage(self.damage)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
