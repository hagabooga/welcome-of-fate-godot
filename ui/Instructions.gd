extends ColorRect

func _on_CloseButton_pressed():
	visible = false
	sound_player.play_sound(43, self)
