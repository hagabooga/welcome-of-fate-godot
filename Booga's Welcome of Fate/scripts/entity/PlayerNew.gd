extends Entity


class_name Player
enum {up,down,left,right}
var facing = down setget set_facing
var equipped_weapon : Weapon setget ,get_weapon


func _ready():
	can_move = true
	set_script(load("res://scripts/player/stats/mage.gd"))
	$BodySprites/CharacterBody/AnimationPlayer.connect("animation_finished",self,"play_all_idle")

func _physics_process(delta):
	change_equip_z()
	if can_move:
		movement_input()
		move_and_slide(velocity.normalized() * move_speed)
	if Input.is_action_just_pressed("attack"):
		basic_attack()
	#global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))

func movement_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity = Vector2.RIGHT
	elif Input.is_action_pressed('ui_left'):
		velocity = Vector2.LEFT
	if Input.is_action_pressed('ui_down'):
		velocity.y = 1
	elif Input.is_action_pressed('ui_up'):
		velocity.y = -1
	if velocity.x == 1:
		self.facing = right
		play_all_body_anims("walk",right)
	elif velocity.x == -1:
		self.facing = left
		play_all_body_anims("walk",left)
	if velocity.x == 0 and velocity.y == -1:
		self.facing = up
		play_all_body_anims("walk",up)
	if velocity.x == 0 and velocity.y == 1:
		self.facing = down
		play_all_body_anims("walk",down)
	if velocity.x == 0 and velocity.y == 0:
		play_all_idle("")

func play_all_idle(last_anim) -> void:
	for x in $BodySprites.get_children():
		if x.get_script() != null:
			x.play_anim("idle", facing)
	can_move = true

func play_all_body_anims(anim, dir, speed_ratio = 8, can_mv = true) -> void:
	for x in $BodySprites.get_children():
		x.play_anim(anim, dir, speed_ratio)
	can_move = can_mv

func get_weapon() -> Weapon:
	for x in $BodySprites.get_children():
		if x is Weapon:
			return x
	return null

func change_equip_z() -> void:
	if self.equipped_weapon != null:
		if facing == up:
			self.equipped_weapon.z_index = -1
		else:
			self.equipped_weapon.z_index = 1

func flip_hitboxes() -> void:
	var flip
	if facing == left:
		flip = -1
	else:
		flip = 1
	#print(facing)
#	if self.equipped_weapon != null:
#		self.equipped_weapon.scale.x = flip
#		if flip == -1:
#			self.equipped_weapon.flip_h = true
#		else:
#			self.equipped_weapon.flip_h = false
	

func basic_attack() -> void:
	play_all_body_anims("slash", facing,8,false)
	self.equipped_weapon.attack_effect(facing)

func set_facing(dir) -> void:
	facing = dir
	change_equip_z()
	flip_hitboxes()
	