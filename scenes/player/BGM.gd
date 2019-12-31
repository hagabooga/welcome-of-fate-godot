extends AudioStreamPlayer2D

var prev_id = null
var current_id = 1
var play_prev : bool


func play_bgm(id : int, p := false):
	play_prev = p
	if stream != null:
		prev_id = current_id
		current_id = id
	stream = sound_player.get_bgm(id)
	play()


func _on_BGM_finished():
	if play_prev:
		play_prev = false
		play_bgm(prev_id)
