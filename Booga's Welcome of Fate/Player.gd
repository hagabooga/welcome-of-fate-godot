extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var facing = "down"
var can_move = true

func _ready():
	player_equip.player = self
	player_equip.player_equipment = $UI/ItemList/Equipment/EquipList
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
		$AnimatedSprite.flip_h = true
		$Tool/AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_side")
	if velocity.x == -1:
		facing = 'side'
		$AnimatedSprite.flip_h = false
		$Tool/AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_side")
	if velocity.x == 0 and velocity.y == -1:
		facing = 'up'
		$AnimatedSprite.flip_h = false
		$Tool/AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up")
	if velocity.x == 0 and velocity.y == 1:
		facing = 'down'
		$AnimatedSprite.flip_h = false
		$Tool/AnimatedSprite.flip_h = false
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
			if (len(grabbables) > 0):
				play_facing_anim("grab", false)
				grabbables[0].emit_signal("action", self)
			else:
				var facing_tile = $Tool.get_player_facing_tile_pos()
				print(facing)
				if facing_tile in world_globals.tilemap_world_objects.get_used_cells():
					play_facing_anim("grab", false)
					var item = item_database.make_item(\
					world_globals.dict_world_object_name[world_globals.tilemap_world_objects.get_cellv(facing_tile)])
					$UI/ItemList.add(item)
					world_globals.tilemap_world_objects.set_cellv(facing_tile, -1)
		if Input.is_action_just_pressed("action"):
			if (player_stats.can_use($Tool.energy_cost)):
				play_facing_anim("slash", false)
				$Tool.use()
				$Tool/AnimatedSprite.play(facing)
#		if Input.is_action_just_pressed("ui_accept"):
#			play_facing_anim("slash", false)
			

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
	var anims = ["grab", "slas"]
	if ($AnimatedSprite.animation.substr(0,4) in anims):
		$AnimatedSprite.play("idle_"+facing)
		can_move = true
		
