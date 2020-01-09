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
	
func set_velocity(angle):
	$AnimationPlayer.play("start")
	$AnimationPlayer.playback_speed = $AnimationPlayer.current_animation_length/travel_time
	velocity = Vector2(cos(angle), sin(angle))

func _on_Hitbox_body_entered(body):
	#print(body)
	if body is Entity:
		body.take_damage(self.damage)
		sound_player.play_sound(56,body)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
