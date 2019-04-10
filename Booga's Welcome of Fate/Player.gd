extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var facing = "down"
var canMove = true


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


func get_action_input():
	var anim = $AnimatedSprite.animation.substr(0,4)
	var grabbables = $HurtArea.get_overlapping_areas()
	if (Input.is_action_just_pressed("z") and (anim == "idle" or anim == "walk") and len(grabbables) > 0):
		if ($AnimatedSprite.animation == "walk_up" or $AnimatedSprite.animation == "idle_up"):
			$AnimatedSprite.play("grab_up")
			facing = "up"
		elif ($AnimatedSprite.animation == "walk_side" or $AnimatedSprite.animation == "idle_side"):
			$AnimatedSprite.play("grab_side")
			facing = "side"
		elif ($AnimatedSprite.animation == "walk_down" or $AnimatedSprite.animation == "idle_down"):
			$AnimatedSprite.play("grab_down")
			facing = "down"
		$HurtArea.get_overlapping_areas()[0].emit_signal("action", self)
		canMove = false
	if Input.is_action_just_pressed("action"):
		$Tool.use()
	if Input.is_action_just_pressed("ui_page_up"):
		$Tool.set_script(load("res://hoe.gd"))

func _physics_process(delta):
	get_action_input()
	if canMove:
		get_input()
		move_and_slide(velocity)
		global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))
	
	
func _on_AnimatedSprite_animation_finished():
	if ($AnimatedSprite.animation.substr(0,4) == "grab"):
		$AnimatedSprite.play("idle_"+facing)
		canMove = true
		
