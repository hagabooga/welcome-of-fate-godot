extends Entity


class_name Player
enum {up,down,left,right}
var facing = down setget set_facing
var equipped_weapon : Weapon = null
var body_sprite = preload("res://scenes/SpriteWithBodyAnimation.tscn")
var did_click_action := false

signal on_full_fade_in

func set_can_move(val : bool):
	.set_can_move(val)

func take_damage(dmg : Damage):
	.take_damage(dmg)
	play_sound(randi()%7+1)

func play_bgm(id : int, prev := false):
	$UI/BGM.play_bgm(id, prev)

func die() -> void:
	if $BodySprites/CharacterBody.current_anim != "die":
		play_all_body_anims("die", 0,1)
		play_bgm(4)


func check_animation():
	if not $BodySprites/CharacterBody.current_anim in ["slash","hack"]:
		did_click_action = false
	else:
		check_load_hotkey()

func get_hotkey_item() -> Item:
	return $UI/UIController/Inventory.get_hotkey_item()

func get_hotkey_holder() -> ItemHolderBase:
	return $UI/UIController/Inventory.get_hotkey_holder()

func anim_finished(anim_name : String):
	#print(anim_name)
	if anim_name != "die":
		play_all_idle(facing)
		can_move = true
	elif anim_name == "die":
		$AnimationPlayer.play("dead")
	

func add_cash(val):
	$UI/UIController/Inventory.cash += val

func _ready():

	connect("on_full_fade_in", self, "fade_out")
	$UI/UIController/Stats.set_stats(self)
	$BodySprites/CharacterBody.connect("frame_changed", self, "check_animation")
	connect("on_hp_change", $UI/UIController/StatusBar, "update_healthBar")
	connect("on_mp_change", $UI/UIController/StatusBar, "update_manaBar")
	connect("on_energy_change", $UI/UIController/StatusBar, "update_energyBar")
	connect("on_xp_change", $UI/UIController/StatusBar, "update_xpBar")
	connect("stat_changed", $UI/UIController/Stats, "update_text")
	get_parent().player = self
	self.can_move = true
	#set_script(load("res://scripts/player/stats/mage.gd"))
	$BodySprites/CharacterBody/AnimationPlayer.connect("animation_finished",self,"anim_finished")
	$UI/UIController/Inventory.connect("on_hotkey_index_change", self, "check_load_hotkey")
	$UI/UIController/Inventory.connect("on_inv_change", self, "check_load_hotkey")
	$UI/UIController/Inventory.connect("on_item_add", $LoadedItems, "add_item")
	#update_stats()
	connect("on_ap_change", $UI/UIController/Stats, "able_use_ap")
	for x in [$UI/UIController/Inventory.inventory_items,$UI/UIController/Inventory.hotkey_items]:
		for i in x:
			i.connect("dropped_data", self, "check_load_hotkey")
			var item = i.item
			if item != null and (item.base == "tool" or item.base == "weapon"):
				var obj = load("res://scenes/weapons/" +item.ming+".tscn").instance()
				obj.item = item
				$LoadedItems.add_item(obj)
	connect("on_kill_enemy", $UI/UIController/Quests, "check_kill_goal")
	
func check_load_hotkey():
	var item = get_hotkey_item()
	ItemHotkeyPreview.set_item_holder($UI/UIController/Inventory.get_hotkey_holder())
	if item != null and (item.base == "weapon" or item.base == "tool") and equipped_weapon == null:
		var obj = $LoadedItems.give_item(item.ming)
		$BodySprites.add_child(obj)
		equipped_weapon = obj
		add_attrib(equipped_weapon.item.stats)
		equipped_weapon.stats = self
		
	elif item != null and (item.base == "weapon" or item.base == "tool")\
		and equipped_weapon != null:
		if equipped_weapon.item.ming == item.ming:
			return
		$BodySprites.remove_child(equipped_weapon)
		remove_attrib(equipped_weapon.item.stats)
		$LoadedItems.add_item(equipped_weapon)
		var obj = $LoadedItems.give_item(item.ming)
		$BodySprites.add_child(obj)
		equipped_weapon = obj
		add_attrib(equipped_weapon.item.stats)
		equipped_weapon.stats = self
	elif (item != null or item == null) and equipped_weapon != null:
		$BodySprites.remove_child(equipped_weapon)
		remove_attrib(equipped_weapon.item.stats)
		$LoadedItems.add_item(equipped_weapon)
		equipped_weapon = null
	if equipped_weapon != null:
		set_facing(facing)
		play_all_body_anims($BodySprites/CharacterBody.current_anim, facing)
		

func _process(delta):
#	if Input.is_action_just_pressed("v"):
#		add_xp(20)
#	if Input.is_action_just_pressed("shift"):
#		self.take_damage(Damage.new(self,1000))
	if get_parent() == get_tree().get_root():
		z_index = 2048
		return
	change_z_index_relative_to_tilemap()
	ItemHotkeyPreview.visible = false
	if get_hotkey_item() != null:
		var click_pos = get_parent().tilemap_soil.world_to_map(get_global_mouse_position())
		var self_pos = get_parent().tilemap_soil.world_to_map(global_position)
		if get_hotkey_item().placeable and click_pos != self_pos\
		 and world_globals.is_pos_adjacent(click_pos, self_pos) and\
		 !(click_pos in get_parent().used_cells):
			ItemHotkeyPreview.visible = true

func _physics_process(delta):
	if is_dead():
		return
	if $UI/UIController/QuestionBox.visible: self.can_move = false
	if $AnimationPlayer.current_animation in ["fade_in", "next_day_fade_in", "fade_out"]:
		self.can_move = false
		return
	if can_move:
		movement_input()
		move_and_slide(velocity.normalized() * move_speed)

func add_item(ming):
	$UI/UIController/Inventory.add_item(item_database.make_item(ming))

func check_click_actions(actions):
	if actions != null:
		for x in actions:
			click_action(x)

func click_action(ca : ClickAction):
	match ca.action:
		ClickAction.ADD_ITEM:
			for item_name in ca.data:
				$UI/UIController/Inventory.add_item(item_database.make_item(item_name))
		ClickAction.CONSUME:
			get_hotkey_holder().consume()
		ClickAction.PLAY_ANIM:
			play_all_body_anims(ca.data[0],facing,ca.data[1],false)
		ClickAction.GAIN_EXP:
			add_xp(ca.data[0])
		ClickAction.OPEN_DIALOGUE:
			$UI/UIController/Dialogue.set_dialogue(ca.data[0],ca.data[1])
		ClickAction.ADD_SKILL_POINT:
			pass
			#add_skill_point()
		

func left_click_obj(obj : Clickable):
	if is_dead():
		return
	#printsad($BodySprites/CharacterBody.current_anim)
	#print(did_click_action)
	if did_click_action or $AnimationPlayer.current_animation in\
			["fade_in", "next_day_fade_in", "fade_out"]:# or !can_move:
		return
	var pos = get_parent().tilemap_grass.world_to_map(global_position)
	var item = get_hotkey_item()
	if (obj.is_self_adjacent(pos)):
		var check_click = obj.check_clicked(item, self)
		if check_click != null:
			did_click_action = true
		check_click_actions(check_click)
		turn_towards_mouse()
		special_click_effects(obj)

func right_click_obj(obj : Clickable):
	if is_dead():
		return
	if $AnimationPlayer.current_animation in ["fade_in", "next_day_fade_in", "fade_out"] or !can_move:
		return
	var pos = get_parent().tilemap_grass.world_to_map(global_position)
	if (obj.is_self_adjacent(pos)):
		check_click_actions(obj.right_clicked())
		turn_towards_mouse()
		special_right_click_effects(obj)

func special_click_effects(obj : Clickable):
	pass

func sleep():
	add_hp(self.max_hp)
	add_mp(self.max_mp)
	add_energy(self.max_energy)
	$AnimationPlayer.play("next_day_fade_in")
	$UI/BGM.stop()

func special_right_click_effects(obj : Clickable):
	if obj is PickableWorldObject:
		$UI/UIController/Inventory.add_item(item_database.make_item(obj.ming))
	#elif obj is TilledSoil and obj.ready_to_harvest():
		#print("WOW")
		#$UI/UIController/Inventory.add_item(item_database.make_item(obj.plant.ming))
	elif obj is Bed:
		$UI/UIController.create_question_box("Do you wish to sleep until the next day?", self, "sleep", "allow_move")
		play_all_idle("")
	elif obj is Chest:
		$UI/UIController.open_close_inventory(false,true)

func allow_move():
	self.can_move = true

func dead():
	$UI/UIController.create_question_box("You Died! Respawn to lose all money?", self, "respawn", "quit_game")
		
func on_next_day():
	world_globals.next_day()
	play_bgm(7,true)

func fade_in(speed := 1.0):
	$AnimationPlayer.play("fade_in",-1,speed)

func fade_out():
	$AnimationPlayer.play("fade_out",-1,5)
	
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

func play_all_body_anims(anim, dir, speed_ratio = 1, can_mv = true) -> void:
	for x in $BodySprites.get_children():
		x.play_anim(anim, dir, speed_ratio)
	self.can_move = can_mv

func flip_hitboxes() -> void:
	var flip
	if facing == right:
		flip = -1
	else:
		flip = 1
	$BodySprites.scale.x = flip

func basic_attack(angle) -> void:
	if equipped_weapon != null and can_use_energy(equipped_weapon.item.energy_cost):
		play_all_body_anims("hack" if equipped_weapon.item.hack else "slash", facing,self.atk_spd,false)
		equipped_weapon.attack_effect(angle)
		use_energy(equipped_weapon.item.energy_cost)

func set_facing(dir) -> void:
	facing = dir
	flip_hitboxes()
	if equipped_weapon != null:
		$BodySprites.move_child(equipped_weapon, 1 if facing == down else 0)
	

func turn_towards(dir) -> void:
	self.facing = dir
	play_all_body_anims("walk",dir,move_speed/150.0)

func turn_towards_mouse() -> float:
	var rad_angle = $BodySprites.global_position.angle_to_point(get_global_mouse_position())
	var angle = rad2deg(rad_angle)
	var cutoff = 60
	var opp = (180 - cutoff)
	if -cutoff < angle and angle < cutoff:
		self.facing = (left)
	elif -opp < angle and angle <= -cutoff:
		self.facing = (down)
	elif (-180 <= angle and angle <= -opp) or (opp < angle and angle <= 180):
		self.facing = (right)
	elif cutoff <= angle and angle <= opp:
		self.facing = (up)
	#print(angle)
	return rad_angle + PI


func respawn():
	play_sound(19)
	play_bgm(get_parent().bgm_id)
	add_hp(self.max_hp)
	play_all_idle("")
	fade_out()

func quit_game():
	print("QUIT")
	get_tree().quit()

func _on_ClickableArea_input_event(viewport, event, shape_idx):
	if is_dead() or !can_move:
		return
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		var item = get_hotkey_item()
		if item != null and can_move:
			if item.act == 0:
				print("consumed: ", item.ming)
				$UI/UIController/Inventory.get_hotkey_holder().consume()
				item_activation(item.ming)
				sound_player.play_sound(51,self)
			elif item.placeable:# == "misc.":
				var click_pos = get_parent().tilemap_soil.world_to_map(get_global_mouse_position())
				var self_pos = get_parent().tilemap_soil.world_to_map(global_position)
				if item.placeable and !(click_pos in get_parent().used_cells) and click_pos != self_pos and\
				world_globals.is_pos_adjacent(click_pos, self_pos):
					var obj = get_parent().create_world_object(item.ming, click_pos)
					$UI/UIController/Inventory.get_hotkey_holder().consume()
					sound_player.play_sound(34,self)
			elif equipped_weapon != null and can_move:
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
					"energy": add_energy(key_vals[v])

func water_can_filled():
	$UI/UIController/Inventory.set_watering_can_ui()

func level_up():
	.level_up()
	$AnimationPlayer.play("level_up")
	$UI/UIController.open_close_stats(false, true)


func play_sound(id : int):
	sound_player.play_sound(id, self)


func _on_AnimationPlayer_animation_started(anim_name):
	match anim_name:
		"fade_in", "next_day_fade_in":
			$UI/UIController/Inventory.visible = false
			self.can_move = false

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_out":
			$UI/UIController/Inventory.visible = true
			self.can_move = true
		"dead":
			$UI/UIController.create_question_box("You Died! Respawn to lose all money?", self, "respawn", "go_to_main_menu")

func close_dialogue():
	$UI/UIController/Dialogue.close()

func go_to_main_menu():
	get_tree().change_scene("res://New/Main Menu.tscn")
