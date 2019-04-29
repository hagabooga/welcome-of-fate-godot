extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var facing = "down"
var can_move = true

func _ready():
	$UI/Tool/AnimatedSprite.connect("animation_finished",$UI/Tool ,"stop_anim")
	player_equip.player_inventory = $UI/Inventory
	play_facing_anim('idle', true)

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
	velocity = velocity.normalized() * speed

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
	var grabbables = $HurtArea.get_overlapping_areas()
	if (anim == "idle" or anim == "walk"):
		if (Input.is_action_just_pressed("z")):
			print(grabbables)
			if (len(grabbables) > 0):
				play_facing_anim("grab", false)
				grabbables[0].apply_action()
				#grabbables[0].emit_signal("action", self)
			else:
				create_world_object_grab()
		if Input.is_action_just_pressed("action"):
			if (player_stats.can_use($UI.tool_action.energy_cost)):
				play_facing_anim($UI.tool_action.tool_anim, false)
				$UI.tool_action.use()
				$UI/Tool/AnimatedSprite.play(facing)
		if Input.is_action_just_pressed("ui_accept"):
			play_facing_anim("slash", false)
			$UI/Weapon/AnimatedSprite.play(facing)
			$UI/Weapon.attack_effect(facing, $AnimatedSprite.flip_h)

func _physics_process(delta):
	var z = world_globals.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	get_action_input()
	if can_move:
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

func flip_h_all_sprites(yes):
	$AnimatedSprite.flip_h = yes
	$UI/Tool/AnimatedSprite.flip_h = yes
	$UI/Weapon/AnimatedSprite.flip_h = yes
