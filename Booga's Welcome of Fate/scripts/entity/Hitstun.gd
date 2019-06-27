extends Node

var hitstun_time = 0

func _physics_process(delta):
	if (hitstun_time > 0):
		hitstun_time -= delta

func in_hitstun() -> bool:
	return hitstun_time > 0
	
