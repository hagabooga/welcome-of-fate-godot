extends Entity

func _ready():
	starting_stats()
	final_stats()


func starting_stats():
	pass

func final_stats():
	hp = max_hp
	mp = max_mp
