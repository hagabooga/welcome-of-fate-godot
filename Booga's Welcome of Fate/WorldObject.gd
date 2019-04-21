extends Node2D

func play_anim(anim):
	$AnimationPlayer.play(anim)
	$Timer.start()
	
func set_texture(path):
	$Sprite.texture = load(path)

func _on_Timer_timeout():
	queue_free()
