extends KinematicBody2D

class_name Projectile

var velocity = Vector2.ZERO
export(int) var speed = 20
export(float) var travel_time = 1
var damage

func _physics_process(delta):
	move_and_slide(velocity.normalized() * speed)
	
func set_velocity(facing, flipped_h):
	$Timer.start(travel_time)
	if facing == "up":
		velocity = Vector2(0,-1)
	elif facing == "side":
		if flipped_h:
			velocity = Vector2(1,0)
		else:
			velocity = Vector2(-1,0)
	elif facing == "down": 
		velocity = Vector2(0,1)
	#print(speed)

func _on_Timer_timeout():
	queue_free()

func _on_Hitbox_area_entered(area):
	var area_par = area.get_parent()
	if area_par is Enemy:
		queue_free()
		area_par.take_damage(damage)

