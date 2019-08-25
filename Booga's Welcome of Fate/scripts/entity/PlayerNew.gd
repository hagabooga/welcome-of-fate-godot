extends Entity


class_name Player
enum {up,down,left,right}
var facing = down setget set_facing
var equipped_weapon : Weapon setget ,get_weapon
var equipped_tool : Tool = Hoe.new()


func _ready():
	#print(equipped_tool)
	#print(Shovel)
	get_parent().player = self
	can_move = true
	set_script(load("res://scripts/player/stats/mage.gd"))
	$BodySprites/CharacterBody/AnimationPlayer.connect("animation_finished",self,"play_all_idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("quest"):
		equipped_tool = Hoe.new()
		print("tool now hoe")
	if Input.is_action_just_pressed("equipment"):
		equipped_tool = Seedbag.new()
		print("tool now seedbag")
	if Input.is_action_just_pressed("inventory"):
		equipped_tool = WateringCan.new()
		print("tool now watering can")
	change_equip_z()
	if can_move:
		movement_input()
		move_and_slide(velocity.normalized() * move_speed)
		if Input.is_action_just_pressed("attack"):
			basic_attack(turn_towards_mouse())
	#global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))

func click_obj(obj : Clickable):
	var pos = get_parent().tilemap_grass.world_to_map(global_position)
	#print(world_globals.is_adjacent(pos, obj.tile_pos))
	print("clicked: ", obj.name, " | In range: ", world_globals.is_adjacent(pos, obj.tile_pos))
	if (world_globals.is_adjacent(pos, obj.tile_pos)):
		obj.clicked(equipped_tool)
		turn_towards_mouse()

func movement_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		velocity = Vector2.RIGHT
	elif Input.is_action_pressed('move_left'):
		velocity = Vector2.LEFT
	if Input.is_action_pressed('move_down'):
		velocity.y = 1
	elif Input.is_action_pressed('move_up'):
		velocity.y = -1
	if velocity.x == 1:
		turn_towards(right)
	elif velocity.x == -1:
		turn_towards(left)
	if velocity.x == 0 and velocity.y == -1:
		turn_towards(up)
	if velocity.x == 0 and velocity.y == 1:
		turn_towards(down)
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
	
func basic_attack(angle) -> void:
	play_all_body_anims("slash", facing,8,false)
	self.equipped_weapon.attack_effect(angle)

func set_facing(dir) -> void:
	facing = dir
	change_equip_z()
	flip_hitboxes()
	
func turn_towards(dir) -> void:
	self.facing = dir
	play_all_body_anims("walk",dir)
	
func turn_towards_mouse() -> float:
	var rad_angle = global_position.angle_to_point(get_global_mouse_position())
	var angle = rad2deg(rad_angle)
	if -30 < angle and angle < 30:
		turn_towards(left)
	elif -150 < angle and angle <= -30:
		turn_towards(down)
	elif (-180 <= angle and angle <= -150) or (150 < angle and angle <= 180):
		turn_towards(right)
	elif 30 <= angle and angle <= 150:
		turn_towards(up)
	#print(angle)
	return rad_angle + PI

