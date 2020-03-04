extends Area2D

export(GDScript) var target = Entity

func get_entities():
	var all = get_overlapping_areas()
	var i = []
	for x in all:
		if x.name == "Hurtbox" and x.get_parent() is target:
			i.append(x.get_parent())
	return i