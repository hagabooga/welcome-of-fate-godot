extends Entity


class_name Player
enum {up,down,left,right}
var facing = down setget set_facing
var equipped_weapon : Weapon = null







func get_hotkey_item():
	return $UI/UIController/Inventory.get_hotkey_item()

func _ready():
	
	get_parent().player = self
	can_move = true
	set_script(load("res://scripts/player/stats/mage.gd"))
	$BodySprites/CharacterBody/AnimationPlayer.connect("animation_finished",self,"play_all_idle")
	$UI/UIController/Inventory.connect("on_hotkey_index_change", self, "check_load_hotkey")
	
func check_load_hotkey():
	var item = get_hotkey_item()
	ItemHotkeyPreview.set_item_holder($UI/UIController/Inventory.get_hotkey_holder())
	if item != null and item.base == "weapon" and equipped_weapon == null:
		var obj = load("res://scenes/weapons/" +item.ming+".tscn").instance()
		$BodySprites.add_child(obj)
		equipped_weapon = obj
	elif item != null and item.base == "weapon" and equipped_weapon != null:
		equipped_weapon.queue_free()
		equipped_weapon = null
		var obj = load("res://scenes/weapons/" +item.ming+".tscn").instance()
		$BodySprites.add_child(obj)
		equipped_weapon = obj
	elif (item != null or item == null) and equipped_weapon != null:
		equipped_weapon.queue_free()
		equipped_weapon = null
		
		
func _process(delta):
	ItemHotkeyPreview.visible = false
	if get_hotkey_item() != null:
		var click_pos = get_parent().tilemap_soil.world_to_map(get_global_mouse_position())
		var self_pos = get_parent().tilemap_soil.world_to_map(global_position)
		if get_hotkey_item().placeable and click_pos != self_pos and world_globals.is_pos_adjacent(click_pos, self_pos) and\
		 !(click_pos in get_parent().used_cells) and get_hotkey_item().type == "misc." :
			ItemHotkeyPreview.visible = true

func _physics_process(delta):
	if $UI/UIController/QuestionBox.visible || $AnimationPlayer.is_playing():
		play_all_idle("")
		return
	if can_move:
		movement_input()
		move_and_slide(velocity.normalized() * move_speed)

func add_item(ming):
	$UI/UIController/Inventory.add_item(item_database.make_item(ming))

func click_action(click_action):
	if click_action != null:
		if click_action.action == Clickable.ADD_ITEM:
			for item_name in click_action.data:
				$UI/UIController/Inventory.add_item(item_database.make_item(item_name))
#		if click_action.action == Clickable.ADD_ITEM:
#			for item_name in click_action.data:
#				$UI/UIController/Inventory.add_item(item_database.make_item(item_name))
				
func left_click_obj(obj : Clickable):
	if $AnimationPlayer.is_playing() or !can_move:
		return
	var pos = get_parent().tilemap_grass.world_to_map(global_position)
	if (obj.is_self_adjacent(pos)):
		click_action(obj.clicked(get_hotkey_item()))
		turn_towards_mouse()
		special_click_effects(obj)
		
func right_click_obj(obj : Clickable):
	if $AnimationPlayer.is_playing() or !can_move:
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
	elif obj is Chest:
		$UI/UIController/Inventory/InventoryList.visible = true
		
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
	if equipped_weapon != null:
		play_all_body_anims("slash", facing,8,false)
		equipped_weapon.attack_effect(angle)

func set_facing(dir) -> void:
	facing = dir
#	change_equip_z()
	flip_hitboxes()
	
func turn_towards(dir) -> void:
	self.facing = dir
	play_all_body_anims("walk",dir)
	
func turn_towards_mouse() -> float:
	var rad_angle = $BodySprites.global_position.angle_to_point(get_global_mouse_position())
	var angle = rad2deg(rad_angle)
	if -30 < angle and angle < 30:
		facing = (left)
	elif -150 < angle and angle <= -30:
		facing = (down)
	elif (-180 <= angle and angle <= -150) or (150 < angle and angle <= 180):
		facing = (right)
	elif 30 <= angle and angle <= 150:
		facing = (up)
	#print(angle)
	return rad_angle + PI
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
		world_globals.next_day()

func _on_ClickableArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		var item = get_hotkey_item()
		if item != null and can_move:
			if item.type == "plant":
				print("consumed: ", item.ming)
				$UI/UIController/Inventory.get_hotkey_holder().consume()
				print(hp)
				item_activation(item.ming)
				print(hp)
			elif item.type == "misc.":
				var click_pos = get_parent().tilemap_soil.world_to_map(get_global_mouse_position())
				var self_pos = get_parent().tilemap_soil.world_to_map(global_position)
				if item.placeable and !(click_pos in get_parent().used_cells) and click_pos != self_pos and\
				world_globals.is_pos_adjacent(click_pos, self_pos):
					var obj = get_parent().create_world_object(item.ming, click_pos)
					$UI/UIController/Inventory.get_hotkey_holder().consume()
			elif item.base == "weapon":
				basic_attack(turn_towards_mouse())

func item_activation(i):
	var data = item_database.item_database
	for x in data.keys():
		if x == i:
			var key_vals = data[x].stats
			for v in key_vals.keys():
				match v:
					"hp": add_hp(key_vals[v])
					"mp": add_mp(key_vals[v])
					