extends Node2D

func set_text_and_play(text):
	if typeof(text) == 2 or typeof(text) == 3:
		if text < 0:
			$Control/Label.add_color_override("font_color", Color.red)
		else:
			$Control/Label.add_color_override("font_color", Color.skyblue)
	$Control/Label.text = str(text)
	$AnimationPlayer.play("popup")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
