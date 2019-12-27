extends Node2D

class_name DamagePopup


func set_text_and_play(text, color_pos, color_neg):
	if typeof(text) == 2 or typeof(text) == 3:
		if text < 0:
			$Control/Label.add_color_override("font_color", color_neg)
		else:
			$Control/Label.add_color_override("font_color", color_pos)
	$Control/Label.text = str(text)
	$AnimationPlayer.play("popup")
	position.x += randi()%70-35
	position.y += randi()%15

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
