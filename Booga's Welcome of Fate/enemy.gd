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

func _process(delta):
	if target:
		follow_player()
		face_player()
		if (attack_in_range):
			$AnimationPlayer.play("attack")
		else:
			$AnimationPlayer.play("idle")

	
func attack():
	player_stats.add_hp(-stats.physical)

func take_damage(val):
	stats.hp -= stepify(val,1)
	if stats.hp <= 0:
		die()

func die():
	queue_free()

func follow_player():
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
		$Sprite.flip_h = false
		$PlayerRange.position.x = orig_playerRange
		$Hurtbox.position.x =  orig_hurtbox
		$AttackArea.position.x = orig_attackArea
	else:
		$Sprite.flip_h = true
		$PlayerRange.position.x = -orig_playerRange
		$Hurtbox.position.x =  -orig_hurtbox
		$AttackArea.position.x = -orig_attackArea
	
func _on_PlayerRange_area_entered(area):
	var area_par = area.get_parent()
	if area_par is Player:
		target = area_par


func _on_PlayerRange_area_exited(area):
	var area_par = area.get_parent()
	if area_par is Player:
		target = null

func _on_AttackArea_area_entered(area):
	var area_par = area.get_parent()
	if area_par is Player:
		attack_in_range = true
	
func _on_AttackArea_area_exited(area):
	var area_par = area.get_parent()
	if area_par is Player:
		attack_in_range = false

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("idle")

func start_stats():
	pass

func final_stats():
	stats.hp = stats.max_hp
	stats.mp = stats.max_mp
