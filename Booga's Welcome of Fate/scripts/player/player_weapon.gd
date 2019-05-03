extends Node2D

var damage setget ,get_damage

func get_damage():
	print("base player_weapon get_damage() called")
	return 0


func set_frames(ming):
	$AnimatedSprite.frames = load("res://frames/%s/%s_frames.tres"%[ming,ming])
	$AnimatedSprite.play("default")

func play_anim(anim):
	$AnimatedSprite.play(anim)

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("default")

func attack_effect(facing, flipped_h):
	pass