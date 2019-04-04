extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x = 1
	if Input.is_action_pressed('ui_left'):
		velocity.x = -1
	if Input.is_action_pressed('ui_down'):
		velocity.y = 1
	if Input.is_action_pressed('ui_up'):
		velocity.y = -1
	if velocity.x == 1:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_side")
	if velocity.x == -1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_side")
	if velocity.x == 0 and velocity.y == -1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up")
	if velocity.x == 0 and velocity.y == 1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_down")
	if velocity.x == 0 and velocity.y == 0:
		if $AnimatedSprite.animation == "walk_up":
			$AnimatedSprite.play("idle_up")
		elif $AnimatedSprite.animation == "walk_side":
			$AnimatedSprite.play("idle_side")
		elif $AnimatedSprite.animation == "walk_down":
			$AnimatedSprite.play("idle_down")
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))
	print(global_position)