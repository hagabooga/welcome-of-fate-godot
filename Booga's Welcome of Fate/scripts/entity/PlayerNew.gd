extends Entity

enum {up,down,left,right}
var facing = down


func _physics_process(delta):
	movement_input()
	move_and_slide(velocity.normalized() * move_speed)
	global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))
	#print(owner.name)

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
		play_all_body_anims("walk",right)
	elif velocity.x == -1:
		facing = left
		play_all_body_anims("walk",left)
	if velocity.x == 0 and velocity.y == -1:
		facing = up
		play_all_body_anims("walk",up)
	if velocity.x == 0 and velocity.y == 1:
		facing = down
		play_all_body_anims("walk",down)
	if velocity.x == 0 and velocity.y == 0:
		play_all_idle(facing)
		
func play_all_idle(dir) -> void:
	#change_equip_z(dir)
	for x in $BodySprites.get_children():
		if x.get_script() != null:
			x.play_anim("idle", dir)

func play_all_body_anims(anim, dir, speed_ratio = 8, can_move = true) -> void:
	for x in $BodySprites.get_children():
		x.play_anim(anim, dir, speed_ratio)