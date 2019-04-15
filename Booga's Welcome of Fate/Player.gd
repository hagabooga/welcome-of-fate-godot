extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var facing = "down"
var can_move = true


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
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_side")
	if velocity.x == -1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_side")
	if velocity.x == 0 and velocity.y == -1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up")
	if velocity.x == 0 and velocity.y == 1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_down")
	if velocity.x == 0 and velocity.y == 0:	
		if $AnimatedSprite.animation == "walk_up":
			$AnimatedSprite.play("idle_up")
		elif $AnimatedSprite.animation == "walk_side":
			$AnimatedSprite.play("idle_side")
		elif $AnimatedSprite.animation == "walk_down":
			$AnimatedSprite.play("idle_down")
	velocity = velocity.normalized() * speed

func get_action_input():
	var anim = $AnimatedSprite.animation.substr(0,4)
	var grabbables = $HurtArea.get_overlapping_areas()
	if (Input.is_action_just_pressed("z") and (anim == "idle" or anim == "walk")):
		if (len(grabbables) > 0):
			if ($AnimatedSprite.animation == "walk_up" or $AnimatedSprite.animation == "idle_up"):
				$AnimatedSprite.play("grab_up")
				facing = "up"
			elif ($AnimatedSprite.animation == "walk_side" or $AnimatedSprite.animation == "idle_side"):
				$AnimatedSprite.play("grab_side")
				facing = "side"
			elif ($AnimatedSprite.animation == "walk_down" or $AnimatedSprite.animation == "idle_down"):
				$AnimatedSprite.play("grab_down")
				facing = "down"
			grabbables[0].emit_signal("action", self)
			can_move = false
		else:
			var facing_tile = $Tool.get_player_facing_tile_pos()
			if facing_tile in world_globals.tilemap_world_objects.get_used_cells():
				var item = item_database.make_item(\
				world_globals.dict_world_object_name[world_globals.tilemap_world_objects.get_cellv(facing_tile)])
				$UI/ItemList.add(item)
				world_globals.tilemap_world_objects.set_cellv(facing_tile, -1)
	if Input.is_action_just_pressed("action"):
		if (player_stats.can_use($Tool.energy_cost)):
			$Tool.use()
	if Input.is_action_just_pressed("ui_page_up"):
		$Tool.set_script(load("res://scripts/tools/hoe.gd"))

func get_ui_input():
	if (Input.is_action_just_pressed("inventory")):
		$UI/ItemList.visible = !$UI/ItemList.visible

func _physics_process(delta):
	var z = world_globals.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	get_ui_input()
	get_action_input()
	if can_move:
		get_input()
		move_and_slide(velocity)
		global_position = Vector2(stepify(global_position.x, 1), stepify(global_position.y, 1))

func _on_AnimatedSprite_animation_finished():
	if ($AnimatedSprite.animation.substr(0,4) == "grab"):
		$AnimatedSprite.play("idle_"+facing)
		can_move = true
		
