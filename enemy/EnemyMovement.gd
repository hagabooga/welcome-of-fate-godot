extends RandomMovementAI

var orig_attackRange

var orig_hurtbox
var orig_collisionBox
var try_timer = 0
var current_try
var hit_pos = null
var target : Entity = null
var attack_in_range : bool = false

func basic_attack() -> void:
	body.find_node("AnimationPlayer").play("attack")

func _ready():
	orig_attackRange = body.find_node("AttackRange").position.x
	orig_hurtbox = body.find_node("Hurtbox").position.x
	orig_collisionBox = body.find_node("CollisionBox").position.x

func get_target():
	for x in body.find_node("RangeOfSight").get_entities():
		if x is Player:
			if x.is_dead():
				target = null
				body.find_node("AnimationPlayer").stop()
			else:
				target = x
			return
	if target != null:
		target = null
		velocity = Vector2.ZERO


func _physics_process(delta):
#	if target != null:
#		$MovementTimer.stop()
#		$ChanceTimer.stop()
#	else:
#		$MovementTimer.start()
#		$ChanceTimer.stop()
	$MovementTimer.paused = target != null
	$ChanceTimer.paused = target != null
	get_target()
	if body.find_node("AnimationPlayer").current_animation == "idle" and target != null and !attack_in_range:
		look(delta)
	elif attack_in_range and body.find_node("AnimationPlayer").current_animation == "idle":
		basic_attack()
	$AnimatedSprite.play("idle_side" if velocity == Vector2.ZERO else "walk_side")
	if velocity != Vector2.ZERO:
		body.change_z_index_relative_to_tilemap()


func look(delta):
	var space_state = get_world_2d().direct_space_state
	var center = target.position
	var top = Vector2(center.x, center.y + body.find_node("CollisionBox").shape.radius)
	var bottom = Vector2(center.x, center.y - body.find_node("CollisionBox").shape.radius)
	var left = Vector2(center.x+ body.find_node("CollisionBox").shape.radius, center.y )
	var right = Vector2(center.x- body.find_node("CollisionBox").shape.radius, center.y )
	for x in [center, top,bottom,left,right]:
		var result = space_state.intersect_ray(position, x, [self], 2)
		if result:
			hit_pos = result.position
			follow_player(delta)
#			if result.collider.name == "Player":
#				if $AnimationPlayer.current_animation == "idle":
#					follow_player(delta)
			return true
	return false
	 
func follow_player(delta) -> void:
	face_target()
	if !(target.global_position.x <= global_position.x && global_position.x < target.global_position.x):
		if global_position.x < target.global_position.x:
			velocity.x = 1
			velocity.y = 0
		else:
			velocity.x = -1
			velocity.y = 0
	if !(target.global_position.y < global_position.y && global_position.y < target.global_position.y ):
		if global_position.y < target.global_position.y:
			velocity.y = 1
		else:
			velocity.y = -1
	if body.get_slide_count() > 0:
		if try_timer <= 0:
			var try = randi()%2
			if try == 0:
				if global_position.y < target.global_position.y:
					velocity.x = 0
					velocity.y = 1
				else:
					velocity.x = 0
					velocity.y = -1
			else:
				if global_position.x < target.global_position.x:
					velocity.x = 1
					velocity.y = 0
				else:
					velocity.x = -1
					velocity.y = 0
			try_timer = 2
			current_try = velocity
		else:
			body.move_and_slide(current_try.normalized() * speed)
			try_timer -=delta
	else:
		body.move_and_slide(velocity.normalized() * speed)

func face_target() -> void:
	if  5 + global_position.x > target.global_position.x:
		$AnimatedSprite.flip_h = false
		body.find_node("CollisionBox").position.x = orig_collisionBox
		body.find_node("Hurtbox").position.x =  orig_hurtbox
		body.find_node("AttackRange").position.x = orig_attackRange
	else:
		$AnimatedSprite.flip_h = true
		body.find_node("CollisionBox").position.x = -orig_collisionBox
		body.find_node("Hurtbox").position.x =  -orig_hurtbox
		body.find_node("AttackRange").position.x = -orig_attackRange
