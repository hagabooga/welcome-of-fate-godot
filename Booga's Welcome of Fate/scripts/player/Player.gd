extends KinematicBody2D
class_name Player

export (int) var speed = 200
var speed_bonus = 0
enum {up,left,down,right}
var velocity = Vector2()
var facing = down
var can_move = true
var equipped_weapon = null
var dash_key = null
var dash_current_time = 0
var dash_time_interval

func _ready():
	dash_time_interval = $DashInterval.wait_time
	player_equip.player_inventory = $UI/Inventory
	player_stats.connect("on_add_hp", self, "make_damage_popup")

func get_all_sprite_with_body_animation():
	var all = []
	all.append($SpriteWithBodyAnimation)
	all.append($Tool)
	for i in range($Equips.get_child_count()):
		all.append($Equips.get_child(i))
	return all

func change_equip_z(dir):
	if dir != down:
		$Equips.z_index = -1
	else:
		$Equips.z_index = 1

func play_all_anims(action, dir, speed_ratio = 8, backwards = false):
	change_equip_z(dir)
	for x in get_all_sprite_with_body_animation():
		if x.get_script() != null:
			x.play_anim(action,dir,backwards)
			x.find_node("AnimationPlayer").playback_speed = speed_ratio

func play_all_idle(dir):
	change_equip_z(dir)
	for x in get_all_sprite_with_body_animation():
		if x.get_script() != null:
			x.play_anim("idle", dir)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x = 1
		dash_current_time = 0
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -1
		dash_current_time = 0
	if Input.is_action_pressed('ui_down'):
		velocity.y = 1
		dash_current_time = 0
	elif Input.is_action_pressed('ui_up'):
		velocity.y = -1
		dash_current_time = 0
	if velocity.x == 1:
		facing = right
		play_all_anims("walk",right)
	elif velocity.x == -1:
		facing = left
		play_all_anims("walk",left)
	if velocity.x == 0 and velocity.y == -1:
		facing = up
		play_all_anims("walk",up)
	if velocity.x == 0 and velocity.y == 1:
		facing = down
		play_all_anims("walk",down)
	if velocity.x == 0 and velocity.y == 0:
		play_all_idle(facing)
	velocity = velocity.normalized() * (speed)
	

func get_action_input():
	var actionables = $Hurtbox.get_overlapping_areas()
	var times = 0
	for x in range(len(actionables)):
		if !(actionables[x-times] is Actionable):
			actionables.erase(actionables[x-times])
			times += 1
	if can_move:
		if (len(actionables) > 0):
			var todo_action = actionables[0]
			show_action_ui(true, todo_action.action_string)
			if (Input.is_action_just_pressed("z")):
				play_all_anims("slash", facing)
				can_move = false
				todo_action.apply_action(self)
		elif get_facing_tile_pos() in world_globals.tilemap_world_objects.get_used_cells():
			show_action_ui(true)
			if (Input.is_action_just_pressed("z")):
				play_all_anims("slash", facing)
				can_move = false
				create_world_object_grab()
		else:
			show_action_ui(false)
		if $Tool.get_script() != null and Input.is_action_just_pressed("action"):
			if (player_stats.can_use($Tool.energy_cost)):
				play_all_anims("slash", facing, 8, true)
				can_move = false
				$Tool.use()
				$Tool.visible = true
				if equipped_weapon != null:
					equipped_weapon.visible = false
		if equipped_weapon != null and Input.is_action_just_pressed("attack"):
			play_all_anims("slash", facing)
			equipped_weapon.attack_effect()
			can_move = false
			if equipped_weapon != null:
				equipped_weapon.visible =true
			$Tool.visible = false

func _physics_process(delta):
	print(dash_key)
	var z = world_globals.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	if !$UI/Dialogue.visible:
		get_action_input()
		if can_move:
			if $DashInterval.is_stopped():
				get_input()
			check_dash()
			move_and_slide_player(delta)
			global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))


func check_dash():
	var inputs = ["ui_right", "ui_left", "ui_up", "ui_down"]
	for x in inputs:
		if Input.is_action_just_pressed(x):
			if dash_key == x:
				$DashInterval.start()
			else:
				dash_key = x

func move_and_slide_player(delta):
	if !$DashInterval.is_stopped():
		if dash_key == 'ui_left':
			velocity.x = -400 * (1 + $DashInterval.time_left - $DashInterval.wait_time * 1.1)
		elif dash_key == 'ui_right':
			velocity.x = 400 * (1 + $DashInterval.time_left - $DashInterval.wait_time * 1.1)
		elif dash_key == 'ui_up':
			velocity.y = -400 * (1 + $DashInterval.time_left - $DashInterval.wait_time * 1.1)
		else:
			velocity.y = 400 * (1 + $DashInterval.time_left - $DashInterval.wait_time * 1.1)
	move_and_slide(velocity)
	if dash_current_time != -1 and dash_current_time < dash_time_interval:
		dash_current_time += delta
	else:
		dash_current_time = -1
		dash_key = null
func _input(event):
	if true:
		if Input.is_action_pressed("ctrl"):
			if Input.is_action_pressed("switch_tool_up"):
				$UI/Inventory.quick_change_tool(false)

func create_world_object_grab():
	var facing_tile = get_facing_tile_pos()
	if facing_tile in world_globals.tilemap_world_objects.get_used_cells():
		var world_object_name = world_globals.dict_world_object_name[world_globals.tilemap_world_objects.get_cellv(facing_tile)]
		var item = item_database.make_item(world_object_name)
		$UI/Inventory.add(item)
		world_globals.tilemap_world_objects.set_cellv(facing_tile, -1)
		var object_grab = load("res://scenes/general/WorldObject.tscn").instance()
		object_grab.set_texture("res://sprites/items/%s.png"%item.ming)
		object_grab.global_position = world_globals.tilemap_grass.map_to_world(facing_tile)
		world_globals.world.add_child(object_grab)
		object_grab.play_anim("grab")
		if facing_tile.y >= 0:
			object_grab.z_index = facing_tile.y
		
		
func get_facing_tile_pos():
	var pos = world_globals.tilemap_soil.world_to_map(global_position)
	if facing == right:
			pos.x += 1
	elif facing == left:
			pos.x += -1
	elif facing == up:
		pos.y += -1
	elif facing == down:
		pos.y += 1
	return pos

func show_action_ui(yes, action = "Pick Up"):
	$UI/Action.visible = yes
	$UI/Action/Label.text = action
	
func start_dialogue(info):
	$UI.close_all_open_ui()
	$UI.can_open_ui = false
	$UI/Dialogue.visible = true
	$UI/Dialogue.make_dialogue_options(info)

func make_damage_popup(val):
	if val != 0:
		var popup = ui_maker.make_damage_popup()
		$PlayerChangeToolSprite.add_child(popup)
		popup.set_text_and_play(val)

func _on_AnimationPlayer_animation_finished(anim_name):
	var substr = anim_name.substr(0,4)
	if substr != "walk" || substr != "idle":
		can_move = true
	$Tool.visible = false
	if equipped_weapon != null:
		equipped_weapon.visible = true


func _on_DashInterval_timeout():
	dash_key = null
	dash_current_time = 0
