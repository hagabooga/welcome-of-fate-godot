extends KinematicBody2D

var velocity = Vector2.DOWN

export(int) var speed = 10
const move_chance  = 8
const sit_chance = 6
const look_chance = 2

func _ready():
	$ChanceTimer.wait_time = randi()%3 + 1
	$MovementTimer.wait_time =  rand_range(0.5,2)

func _process(delta):
	change_z_index_relative_to_tilemap()
	if !$MovementTimer.is_stopped():
		move_and_slide(velocity * speed)
	

func _on_ChanceTimer_timeout():
	if randi()%move_chance == 0:
		velocity = [Vector2.DOWN, Vector2.UP, Vector2.LEFT, Vector2.RIGHT,
		Vector2(1,1),Vector2(-1,1),Vector2(1,-1),Vector2(-1,-1)][randi() % 8]
		$AnimatedSprite.play("walk_up" if velocity.y < 0 else "walk_down")
		if velocity.x > 0:
			$AnimatedSprite.play("walk_side")
			$AnimatedSprite.flip_h = true;
		elif velocity.x < 0:
			$AnimatedSprite.play("walk_side")
			$AnimatedSprite.flip_h = false;
		$MovementTimer.start()
		$ChanceTimer.wait_time = rand_range($MovementTimer.wait_time+.1,4)
	elif randi()%sit_chance == 0:
		if velocity.x > 0 or velocity.x < 0:
			$AnimatedSprite.play("sit_side" if randi()%2 else "idle_side")
		elif velocity.y > 0:
			$AnimatedSprite.play("sit_down" if randi()%2 else "idle_down")
		else:
			$AnimatedSprite.play("sit_up" if randi()%2 else "idle_up")
		$ChanceTimer.wait_time = 8
	elif randi()%look_chance == 0 and (velocity.x > 0 or velocity.x < 0):
		$AnimatedSprite.play(["idle_side", "idle_down", "idle_up"][randi()%3])

func _on_MovementTimer_timeout():
	if velocity.x > 0 or velocity.x < 0:
		$AnimatedSprite.play("idle_side")
	elif velocity.y > 0:
		$AnimatedSprite.play("idle_down")
	else:
		$AnimatedSprite.play("idle_up")

func change_z_index_relative_to_tilemap() -> void:
	var z = owner.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = owner.tilemap_soil.world_to_map(global_position).y