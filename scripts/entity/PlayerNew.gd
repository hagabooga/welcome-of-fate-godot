extends Entity


class_name Player
enum {up,down,left,right}
var facing = down setget set_facing



func get_hotkey_item():
	return $UI/UIController/Inventory.get_hotkey_item()

func _ready():
	#print(equipped_tool)
	#print(Shovel)
	#equipped_hotkey = Hoe.new()
	get_parent().player = self
	can_move = true
	set_script(load("res://scripts/player/stats/mage.gd"))
	$BodySprites/CharacterBody/AnimationPlayer.connect("animation_finished",self,"play_all_idle")

func _physics_process(delta):
	#$Camera2D.position = position
	if $UI/UIController/QuestionBox.visible || $AnimationPlayer.is_playing():
		play_all_idle("")
		print("cant do anything")
		return
#	change_equip_z()
	if can_move:
		movement_input()
		move_and_slide(velocity.normalized() * move_speed)
		#if Input.is_action_just_pressed("attack"):
			#play_all_body_anims("slash",facing,8,false)
			#basic_attack(turn_towards_mouse())
	#global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))

func click_action(click_action):
	if click_action != null:
		if click_action.action == Clickable.ADD_ITEM:
			$UIController/Inventory.add_item(item_database.make_item(click_action.data[0]))
		elif click_action.action == Clickable.OPEN_OTHER_INVENTORY:
			#$UI/UIController/Inventory/OtherInventoryList.visible = true
			$UI/UIController/Inventory/InventoryList.visible = true
			click_action.data[1].visible = true
			#$UI/UIController/Inventory.add_child(click_action.data[1])
#			$UI/UIController/Inventory.set_other_inventory_size(click_action.data[0])
#			print(click_action.data[0])
#			var i = 0
#			for holder in click_action.data[1]:
#				$UI/UIController/Inventory/OtherInventoryList/GridContainer.get_child(i).set_item(holder.item, holder.count)
#				i += 1
#			$UI/UIController/Inventory.resize_other_inventory()
				
func left_click_obj(obj : Clickable):
	if $AnimationPlayer.is_playing():
		return
	var pos = get_parent().tilemap_grass.world_to_map(global_position)
	if (obj.is_self_adjacent(pos)):
		click_action(obj.clicked(get_hotkey_item()))
		turn_towards_mouse()
		special_click_effects(obj)
		
func right_click_obj(obj : Clickable):
	if $AnimationPlayer.is_playing():
		return
	var pos = get_parent().tilemap_grass.world_to_map(global_position)
	if (obj.is_self_adjacent(pos)):
		click_action(obj.right_clicked())
		turn_towards_mouse()
		special_right_click_effects(obj)
		
func special_click_effects(obj : Clickable):
	pass
		
func special_right_click_effects(obj : Clickable):
	if obj is PickableWorldObject:
		$UI/UIController/Inventory.add_item(item_database.make_item(obj.ming))
	elif obj is TilledSoil and obj.ready_to_harvest():
		$UI/UIController/Inventory.add_item(item_database.make_item(obj.plant.ming))
	elif obj is Bed:
		$UI/UIController.create_question_box("Do you wish to sleep until the next day?", self, "sleep")
		
func sleep():
	$AnimationPlayer.play("fade_in")
	

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

#func change_equip_z() -> void:
#	if self.equipped_weapon != null:
#		if facing == up:
#			self.equipped_weapon.z_index = -1
#		else:
#			self.equipped_weapon.z_index = 1

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
#	change_equip_z()
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
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
		world_globals.next_day()