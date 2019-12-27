extends Node2D

var current_target = null

func _ready():
	$TargetIndicator/Sprite/AnimationPlayer.play("updown")
	player_stats.connect("on_add_hp", self, "take_damage_change_target")
	

func _process(delta):
	var enemies = get_enemies()
	if len(enemies) > 0:
		target_enemy(enemies)
		if Input.is_action_just_pressed("next_enemy"):
			 change_target(enemies)
		show_indicator()
	else:
		$TargetHealth.visible = false
		$TargetIndicator.visible = false
		current_target = null

func take_damage_change_target(val):
	if val < 0:
		current_target = val.enemy
	
	
func change_target(enemies):
	var copy_enemies = enemies
	if (current_target != null):
		copy_enemies.erase(current_target)
		if len(copy_enemies) > 0:
			current_target = copy_enemies[0]
	
func target_enemy(enemies):
	if current_target == null:
		current_target = enemies[0]
	elif current_target in enemies:
		current_target = current_target

func show_indicator():
	if current_target != null:
		$TargetIndicator.visible = true
		$TargetHealth.visible = true
		$TargetIndicator.z_index = current_target.z_index + 1
		$TargetIndicator.global_position = current_target.find_node("AboveHeadPos").global_position
		$TargetHealth/Name.text = current_target.ming
		#$TargetHealth.value = (current_target.stats.hp / current_target.stats.max_hp) * 100
	
		
func get_first_enemy() -> Enemy: 
	for x in $Range.get_overlapping_bodies():
		if x is Enemy:
			return x
	return null
	
func get_enemies(): 
	var enemies = []
	for x in $Range.get_overlapping_bodies():
		if x is Enemy:
			enemies.append(x)
	return enemies