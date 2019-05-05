extends KinematicBody2D

class_name Enemy

var stats = Attributes.new()
var attack_in_range = false
var target = null
var move_speed = 35

var orig_playerRange
var orig_hurtbox
var orig_attackArea

func _ready():
	orig_playerRange = $PlayerRange.position.x
	orig_hurtbox = $Hurtbox.position.x
	orig_attackArea = $AttackArea.position.x
	start_stats()
	final_stats()
	$AnimationPlayer.play("idle")
	#detect_radius = $PlayerRange/CollisionShape2D.shape.radius

func _process(delta):
	var z = world_globals.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	$Sprite.self_modulate = Color.white	
	if target:
		if look():
			if (attack_in_range):
				$AnimationPlayer.play("attack")
		else:
			$AnimationPlayer.play("idle")
	update()


var hit_pos
func look():
	var space_state = get_world_2d().direct_space_state
	var target_radius = target.get_node("CollisionBox").shape.radius
	var result = space_state.intersect_ray(position, target.position, [self], collision_mask)
	if result:
		hit_pos = result.position
		if result.collider.name == "Player":
			if $AnimationPlayer.current_animation == "idle":
				follow_player()
		return true
	return false
			

#var detect_radius
#var vis_color = Color(.867, .91,.247,.1)
#var laser_color = Color.red

#func _draw():
#	draw_circle(Vector2.ZERO,detect_radius, vis_color)
#	if target:
#		var pos = (position - hit_pos)
#		pos.y=-pos.y
#		draw_circle(pos, 5, laser_color)
#		draw_line(Vector2.ZERO, pos, laser_color)
	
	
func attack():
	player_stats.add_hp(-stats.physical)

func take_damage(val):
	var final_val = stepify(val,1) 
	stats.hp -= final_val
	var popup = ui_maker.make_damage_popup()
	popup.set_text_and_play(final_val)
	$AboveHeadPos.add_child(popup)
	if stats.hp <= 0:
		die()

func die():
	$AnimationPlayer.play("die")

func follow_player():
	face_player()
	if (target and !attack_in_range):
		var velocity = Vector2.ZERO
		if !(target.position.x -5 <= position.x && position.x < target.position.x+5):
			if position.x < target.position.x:
				velocity.x = 1
			else:
				velocity.x = -1
		if !(target.position.y < position.y && position.y < target.position.y):
			if position.y < target.position.y:
				velocity.y = 1
			else:
				velocity.y = -1
		move_and_slide(velocity.normalized() * move_speed)



func face_player():
	if position.x < target.position.x:
		$Sprite.scale.x = 1#$Sprite.flip_h = false
		$PlayerRange.position.x = orig_playerRange
		$Hurtbox.position.x =  orig_hurtbox
		$AttackArea.position.x = orig_attackArea
	else:
		$Sprite.scale.x = -1
		#$Sprite.flip_h = true
		$PlayerRange.position.x = -orig_playerRange
		$Hurtbox.position.x =  -orig_hurtbox
		$AttackArea.position.x = -orig_attackArea
	
func _on_PlayerRange_area_entered(area):
	if !target:
		var area_par = area.get_parent()
		if area_par is Player:
			target = area_par


func _on_PlayerRange_area_exited(area):
	var area_par = area.get_parent()
	if area_par is Player:
		target = null

func _on_AttackArea_area_entered(area):
	var area_par = area.get_parent()
	if area_par == target:
		attack_in_range = true
	
func _on_AttackArea_area_exited(area):
	var area_par = area.get_parent()
	if area_par == target:
		attack_in_range = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
	else:
		$AnimationPlayer.play("idle")

func start_stats():
	pass

func final_stats():
	stats.hp = stats.max_hp
	stats.mp = stats.max_mp
