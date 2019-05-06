extends KinematicBody2D

export (int) var speed = 2
var speed_bonus = 0
enum {up,left,down,right}
var velocity = Vector2()
var facing = "down"
var can_move = true

func _process(delta):
	get_input()
	move_and_slide(velocity)
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x = 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -1
	if Input.is_action_pressed('ui_down'):
		velocity.y = 1
	elif Input.is_action_pressed('ui_up'):
		velocity.y = -1
	velocity = velocity.normalized() * (speed)
	