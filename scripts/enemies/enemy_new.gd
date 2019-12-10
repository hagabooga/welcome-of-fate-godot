extends Entity
class_name Enemy

var target : Entity = null

var orig_attackRange
var orig_hurtbox
var orig_collisionBox
var try_timer = 0
var current_try
var hit_pos = null
var attack_in_range : bool = false

var player_script = load("res://scripts/entity/PlayerNew.gd")
var item_spit_out_scene = load("res://ItemSpitOut.tscn")

var item_drops = {}
	
func _ready():
	self.atk_spd = 1
	orig_attackRange = $AttackRange.position.x
	orig_hurtbox = $Hurtbox.position.x
	orig_collisionBox = $CollisionBox.position.x
	starting_stats()
	final_stats()
	
func _enter_tree():
	modulate.a = 0
	$AnimationPlayer.play("spawn")
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	get_target()
	if $AnimationPlayer.current_animation == "idle" and target != null and !attack_in_range:
		look(delta)
	elif attack_in_range and $AnimationPlayer.current_animation == "idle":
		basic_attack()
		#print(target.hp)
	$Sprite.play("idle" if velocity == Vector2.ZERO else "move")
	

func die() -> void:
	$AnimationPlayer.play("die")
	

func take_damage(dmg : Damage) -> void:
	if $AnimationPlayer.current_animation != "die":
		.take_damage(dmg)
		if hp <= 0:
			die()

func basic_attack() -> void:
	$AnimationPlayer.play("attack")
	
	
func deal_damage_to_target() -> void:
	if target == null:
		print("target does not exist!!! cannot deal damage")
	if target != null and weakref(target).get_ref():
		target.take_damage(Damage.new(self, self.physical))


func look(delta):
	var space_state = get_world_2d().direct_space_state
	var center = target.position
	var top = Vector2(center.x, center.y + $CollisionBox.shape.radius)
	var bottom = Vector2(center.x, center.y - $CollisionBox.shape.radius)
	var left = Vector2(center.x+ $CollisionBox.shape.radius, center.y )
	var right = Vector2(center.x- $CollisionBox.shape.radius, center.y )
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
	
	if !(target.position.x - 5 <= position.x && position.x < target.position.x+5):
		if position.x < target.position.x:
			velocity.x = 1
		else:
			velocity.x = -1
	if !(target.position.y - 5 < position.y && position.y < target.position.y + 5):
		if position.y < target.position.y:
			velocity.y = 1
		else:
			velocity.y = -1
	if get_slide_count() > 0:
		if try_timer <= 0:
			var try = randi()%2
			if try == 0:
				if position.y < target.position.y:
					velocity.x = 0
					velocity.y = 1
				else:
					velocity.x = 0
					velocity.y = -1
			else:
				if position.x < target.position.x:
					velocity.x = 1
					velocity.y = 0
				else:
					velocity.x = -1
					velocity.y = 0
			try_timer = 2
			current_try = velocity
		else:
			move_and_slide(current_try.normalized() * move_speed)
			try_timer -=delta
	else:
		move_and_slide(velocity.normalized() * move_speed)

func face_target() -> void:
	if position.x > target.position.x:
		$RandomMovementAI/AnimatedSprite.flip_h = false
		$CollisionBox.position.x = orig_collisionBox
		$Hurtbox.position.x =  orig_hurtbox
		$AttackRange.position.x = orig_attackRange
	else:
		$RandomMovementAI/AnimatedSprite.flip_h = true
		$CollisionBox.position.x = -orig_collisionBox
		$Hurtbox.position.x =  -orig_hurtbox
		$AttackRange.position.x = -orig_attackRange

func starting_stats() -> void:
	pass

func final_stats():
	hp = self.max_hp
	mp = self.max_mp

func get_target():
	for x in $RangeOfSight.get_entities():
		if x is player_script:
			target = x
			return
	target = null

func _on_AttackRange_body_entered(body):
	if target == body:
		attack_in_range = true


func _on_AttackRange_body_exited(body):
	if target == body:
		attack_in_range = false


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("idle")


func _on_Enemy_input_event(viewport, event, shape_idx):
	#print(event)
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print(name, " clicked with mouse!")
			
func spit_out_item():
	for x in item_drops.keys():
		var i = 0 #randi()%100
		if i < item_drops[x]:
			var spit = item_spit_out_scene.instance()
			get_parent().add_child(spit)
			spit.set_item(x)
			spit.play_spit_out(global_position)
