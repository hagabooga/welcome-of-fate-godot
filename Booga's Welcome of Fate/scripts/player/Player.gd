extends KinematicBody2D

class_name Player

export (int) var speed = 200
var speed_bonus = 0

var velocity = Vector2()
var facing = "down"
var can_move = true

func _ready():
	$UI/Tool/AnimatedSprite.connect("animation_finished",$UI/Tool ,"stop_anim")
	player_equip.player_inventory = $UI/Inventory
	play_facing_anim('idle', true)
	player_stats.connect("on_add_hp", self, "make_damage_popup")

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
		facing = 'side'
		flip_h_all_sprites(true)
		$AnimatedSprite.play("walk_side")
	if velocity.x == -1:
		facing = 'side'
		flip_h_all_sprites(false)
		$AnimatedSprite.play("walk_side")
	if velocity.x == 0 and velocity.y == -1:
		facing = 'up'
		flip_h_all_sprites(false)
		$AnimatedSprite.play("walk_up")
	if velocity.x == 0 and velocity.y == 1:
		facing = 'down'
		flip_h_all_sprites(false)
		$AnimatedSprite.play("walk_down")
	if velocity.x == 0 and velocity.y == 0:
		if $AnimatedSprite.animation == "walk_up":
			$AnimatedSprite.play("idle_up")
		elif $AnimatedSprite.animation == "walk_side":
			$AnimatedSprite.play("idle_side")
		elif $AnimatedSprite.animation == "walk_down":
			$AnimatedSprite.play("idle_down")
	velocity = velocity.normalized() * (speed)

func play_facing_anim(anim, canmove):
	if ($AnimatedSprite.animation == "walk_up" or $AnimatedSprite.animation == "idle_up"):
		$AnimatedSprite.play(anim + "_up")
		facing = "up"
	elif ($AnimatedSprite.animation == "walk_side" or $AnimatedSprite.animation == "idle_side"):
		$AnimatedSprite.play(anim + "_side")
		facing = "side"
	elif ($AnimatedSprite.animation == "walk_down" or $AnimatedSprite.animation == "idle_down"):
		$AnimatedSprite.play(anim + "_down")
		facing = "down"
	can_move = canmove

func get_action_input():
	var anim = $AnimatedSprite.animation.substr(0,4)
	var actionables = $HurtArea.get_overlapping_areas()
	var times = 0
	for x in range(len(actionables)):
		if !(actionables[x-times] is Actionable):
			actionables.erase(actionables[x-times])
			times += 1
	if (anim == "idle" or anim == "walk"):
		if (len(actionables) > 0):
			var todo_action = actionables[0]
			show_action_ui(true, todo_action.action_string)
			if (Input.is_action_just_pressed("z")):
				play_facing_anim("grab", false)
				todo_action.apply_action(self)
		elif get_facing_tile_pos() in world_globals.tilemap_world_objects.get_used_cells():
			show_action_ui(true)
			if (Input.is_action_just_pressed("z")):
				create_world_object_grab()
		else:
			show_action_ui(false)
		if Input.is_action_just_pressed("action"):
			if (player_stats.can_use($UI.tool_action.energy_cost)):
				play_facing_anim($UI.tool_action.tool_anim, false)
				$UI.tool_action.use()
				$UI/Tool/AnimatedSprite.play(facing)
				$AnimatedSprite.speed_scale = 10
		if Input.is_action_just_pressed("attack"):
			if $UI/Weapon.get_child_count() > 0:
				play_facing_anim("slash", false)
				$UI/Weapon.get_child(0).reset()
				$UI/Weapon.get_child(0).play_anim(facing,10 * player_stats.atk_spd)
				$UI/Weapon.get_child(0).attack_effect(facing, $AnimatedSprite.flip_h)
				$AnimatedSprite.speed_scale = 10 * player_stats.atk_spd

func _physics_process(delta):
	var z = world_globals.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	if !$UI/Dialogue.visible:
		get_action_input()
		if can_move :
			get_input()
			move_and_slide(velocity)
			global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))

func _input(event):
	var anim = $AnimatedSprite.animation.substr(0,4)
	if (anim == "idle" or anim == "walk"):
		if Input.is_action_pressed("ctrl"):
			if Input.is_action_pressed("switch_tool_up"):
				$UI/Inventory.quick_change_tool(false)

func create_world_object_grab():
	var facing_tile = get_facing_tile_pos()
	if facing_tile in world_globals.tilemap_world_objects.get_used_cells():
		play_facing_anim("grab", false)
		var world_object_name = world_globals.dict_world_object_name[world_globals.tilemap_world_objects.get_cellv(facing_tile)]
		var item = item_database.make_item(world_object_name)
		$UI/Inventory.add(item)
		world_globals.tilemap_world_objects.set_cellv(facing_tile, -1)
		var object_grab = load("res://WorldObject.tscn").instance()
		object_grab.set_texture("res://sprites/items/%s.png"%item.ming)
		object_grab.global_position = world_globals.tilemap_grass.map_to_world(facing_tile)
		world_globals.world.add_child(object_grab)
		object_grab.play_anim("grab")
		if facing_tile.y >= 0:
			object_grab.z_index = facing_tile.y
		
		
func _on_AnimatedSprite_animation_finished():
	var anims = ["grab", "slas", "rsls"]
	if ($AnimatedSprite.animation.substr(0,4) in anims):
		$AnimatedSprite.play("idle_"+facing)
		$AnimatedSprite.speed_scale = 1
		can_move = true
		
func get_facing_tile_pos():
	var pos = world_globals.tilemap_soil.world_to_map(global_position)
	if facing == "side":
		if($AnimatedSprite.flip_h == true):
			pos.x += 1
		else:
			pos.x += -1
	elif facing == "up":
		pos.y += -1
	elif facing == "down":
		pos.y += 1
	return pos

func show_action_ui(yes, action = "Pick Up"):
	$UI/Action.visible = yes
	$UI/Action/Label.text = action

func flip_h_all_sprites(yes):
	$AnimatedSprite.flip_h = yes
	if yes:
		$UI/Weapon.scale.x = -1
	else:
		$UI/Weapon.scale.x = 1

	
func start_dialogue(info):
	$UI.close_all_open_ui()
	$UI.can_open_ui = false
	$UI/Dialogue.visible = true
	$UI/Dialogue.make_dialogue_options(info)

func make_damage_popup(val):
	if val != 0:
		var popup = ui_maker.make_damage_popup()
		$UI/PlayerChangeToolSprite.add_child(popup)
		popup.set_text_and_play(val)
