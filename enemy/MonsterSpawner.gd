tool
extends Node2D

export (PackedScene) var enemy_to_spawn
export (float) var spawn_radius

var spawned_enemy = null

func _ready():
	if Engine.editor_hint:
		var s = Sprite.new()
		s.texture = load("res://sprites/Monster_Spawner.webp")
		add_child(s)
		scale = Vector2(.3,.3)
		$Area2D/CollisionShape2D.shape.radius = spawn_radius
	else:
		$Area2D/CollisionShape2D.shape.radius = spawn_radius
		$Timer.wait_time = randi()%7+7
		#spawn()

func _process(delta):
	if !Engine.editor_hint:
		if (spawned_enemy == null or !is_instance_valid(spawned_enemy)) and $Timer.is_stopped():
			$Timer.wait_time = randi()%4+3
			$Timer.start()

func spawn():
	var radius = rand_range(0, $Area2D/CollisionShape2D.shape.radius)
	var e = enemy_to_spawn.instance()
	get_parent().add_child(e)
	e.global_position = global_position + Vector2(rand_range(-radius,radius),rand_range(-radius,radius))/4
	spawned_enemy = e
	

func _on_Timer_timeout():
	spawn()
