extends Node2D

func set_frames(ming):
	$AnimatedSprite.frames = load("res://frames/%s/%s_frames.tres"%[ming,ming])
	$AnimatedSprite.play("default")

func play_anim(anim):
	$AnimatedSprite.play(anim)

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("default")

func attack_effect(facing, flipped_h):
	pass