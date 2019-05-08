extends KinematicBody2D
class_name Player

export (int) var speed = 200
var speed_bonus = 0
enum {up,left,down,right}
var velocity = Vector2()
var facing = "down"
var can_move = true


func _ready():
	player_equip.player_inventory = $UI/Inventory
	#play_facing_anim('idle', true)
	$BodySprite.play_idle(down)
	player_stats.connect("on_add_hp", self, "make_damage_popup")
	$BodySprite.connect("anim_finished",self,"body_anim_finished")


func play_all_anims(action, dir, once = false):
	$BodySprite.play_action_anim(action, dir, once)
	for i in range($Equips.get_child_count()):
		$Equips.get_child(i).play_action_anim(action, dir, once)

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
		facing = 'right'
		flip_h_all_sprites(true)
		play_all_anims("walk",right)
	elif velocity.x == -1:
		facing = 'left'
		flip_h_all_sprites(false)
		play_all_anims("walk",left)
	if velocity.x == 0 and velocity.y == -1:
		facing = 'up'
		flip_h_all_sprites(false)
		play_all_anims("walk",up)
	if velocity.x == 0 and velocity.y == 1:
		facing = 'down'
		flip_h_all_sprites(false)
		play_all_anims("walk",down)
	if velocity.x == 0 and velocity.y == 0:
		facing = global_id.id_facing_string[$BodySprite.current_direction]
		$BodySprite.play_idle($BodySprite.current_direction)
		$Equips.get_child(0).play_idle($BodySprite.current_direction)
	velocity = velocity.normalized() * (speed)

func get_action_input():
	var actionables = $Hurtbox.get_overlapping_areas()
	var times = 0
	for x in range(len(actionables)):
		if !(actionables[x-times] is Actionable):
			actionables.erase(actionables[x-times])
			times += 1
	if can_anim():
		if (len(actionables) > 0):
			var todo_action = actionables[0]
			show_action_ui(true, todo_action.action_string)
			if (Input.is_action_just_pressed("z")):
				$BodySprite.play_action_anim("slash", $BodySprite.current_direction,true)
				todo_action.apply_action(self)
		elif get_facing_tile_pos() in world_globals.tilemap_world_objects.get_used_cells():
			show_action_ui(true)
			if (Input.is_action_just_pressed("z")):
				create_world_object_grab()
		else:
			show_action_ui(false)
		if Input.is_action_just_pressed("action"):
			if (player_stats.can_use($UI.tool_action.energy_cost)):
				$BodySprite.play_action_anim($UI.tool_action.tool_anim, $BodySprite.current_direction,true)
				$UI.tool_action.use()
				$UI/Tool/AnimatedSprite.play(check_facing_side())
		if Input.is_action_just_pressed("attack"):
			var anim_face = facing
			play_all_anims("slash",$BodySprite.current_direction,true)
			anim_face = check_facing_side()
			$Equips.get_child(0).reset()
			$BodySprite.anim_speed = 10
			$Equips.get_child(0).anim_speed = 10


func check_facing_side():
	if facing == "left" or facing == "right":
		return "side"
	return facing

func _physics_process(delta):
	var z = world_globals.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	if !$UI/Dialogue.visible:
		get_action_input()
		if can_move and can_anim():
			get_input()
			move_and_slide(velocity)
			global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))

func _input(event):
	if can_anim():
		if Input.is_action_pressed("ctrl"):
			if Input.is_action_pressed("switch_tool_up"):
				$UI/Inventory.quick_change_tool(false)

func can_anim():
	return $BodySprite.current_action == "idle" || $BodySprite.current_action == "walk"

func create_world_object_grab():
	var facing_tile = get_facing_tile_pos()
	if facing_tile in world_globals.tilemap_world_objects.get_used_cells():
		#play_facing_anim("grab", false)
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
	if check_facing_side() == "side":
		if(facing == "right"):
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
	if yes:
		$Tool.scale.x = -1
	else:
		$Tool.scale.x = 1

	
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

func body_anim_finished():
	$BodySprite.play_idle($BodySprite.current_direction)
