#extends "res://scripts/player/player_weapon.gd"
#
#var projectile = load("res://scenes/projectiles/MagicShot.tscn")
#
#
#
#func attack_effect(facing, flipped_h):
#	var proj = projectile.instance()
#	world_globals.world.add_child(proj)
#	proj.global_position = global_position
#	proj.set_velocity(facing, flipped_h)
#	proj.damage = proj_damage()
#
#func proj_damage():
#	return player_stats.magical * 0.2
extends PlayerBaseSprite
var damage setget ,get_damage
var targets_hit = []

func _ready():
	$Hitbox/CollisionShape2D.disabled = true

#func _process(delta):
#	update()
#
#func _draw():
#	var col = Color.red
#	if !$Hitbox/CollisionShape2D.disabled:
#		col.a = 0.5
#		draw_circle($Hitbox.position, $Hitbox/CollisionShape2D.shape.radius, col)

func get_damage():
	#print("base player_weapon get_damage() called")
	return player_stats.physical
	
func reset():
	$AnimationPlayer.stop()

func play_anim(anim, speed):
	$AnimationPlayer.playback_speed = speed
	$AnimationPlayer.play(anim)
	targets_hit = []
	
	

func attack_effect(facing, flipped_h):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if $AnimationPlayer.assigned_animation != "idle":
		$AnimationPlayer.play("idle")
		$Hitbox/CollisionShape2D.disabled = true
		

func _on_AnimationPlayer_animation_started(anim_name):
	$Hitbox/CollisionShape2D.disabled = false


func _on_Hitbox_area_entered(area):
	if area.name == "Hurtbox":
		var area_par = area.get_parent()
		if not area_par in targets_hit and area_par is Enemy:
			area_par.take_damage(self.damage)
			targets_hit.append(area_par)

func _on_MagicWand_anim_finished():
	play_idle(current_direction)
