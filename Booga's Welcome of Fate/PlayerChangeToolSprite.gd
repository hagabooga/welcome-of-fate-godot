extends Sprite


func set_texture(path):
	texture = load(path)
	$Timer.start()

func _on_Timer_timeout():
	texture = null
