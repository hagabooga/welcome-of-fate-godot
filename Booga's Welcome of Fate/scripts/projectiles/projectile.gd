extends KinematicBody2D

class_name Projectile
enum {up,left,down,right}
var velocity = Vector2.ZERO
export(int) var speed = 20
export(float) var travel_time = 1
var damage
var pierce = 1
var targets_hit = []

func _physics_process(delta):
	move_and_slide(velocity.normalized() * speed)
	
func set_velocity(facing):
	$Timer.start(travel_time)
	if facing == up:
		velocity = Vector2(0,-1)
	elif facing == left:
		velocity = Vector2(-1,0)
	elif facing == right:
		velocity = Vector2(1,0)
	else:
		velocity = Vector2(0,1)


func _on_Timer_timeout():
	queue_free()

func _on_Hitbox_area_entered(area):
	var area_par = area.get_parent()
	if area_par is Enemy:
		targets_hit.append(area)
		if len(targets_hit) == pierce:
			queue_free()
		area_par.take_damage(damage)

