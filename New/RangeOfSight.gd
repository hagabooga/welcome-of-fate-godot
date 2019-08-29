extends Area2D

func get_entities():
	var all = get_overlapping_bodies()
	for x in all:
		if not x is Entity:
			all.erase(x)
	all.erase(get_parent())
	return all
		
	