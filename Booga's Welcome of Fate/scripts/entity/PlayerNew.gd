extends Entity

enum {up,down,left,right}
var facing

func _physics_process(delta):
	move_and_slide(velocity)

func movement_input() -> void:
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
		facing = right
		play_all_body_anims("walk",right, true)
	elif velocity.x == -1:
		facing = left
		play_all_body_anims("walk",left, true)
	if velocity.x == 0 and velocity.y == -1:
		facing = up
		play_all_body_anims("walk",up, true)
	if velocity.x == 0 and velocity.y == 1:
		facing = down
		play_all_body_anims("walk",down, true)
	if velocity.x == 0 and velocity.y == 0:
		play_all_idle(facing)
		
func play_all_body_anims(anim, dir, can_move) -> void:
	for x in range($BodySprites.get_child_count()):
		$BodySprites.get_child(x).play_anim(anim, dir)