extends Node

var data = {}

func add_map_data(map : Map):
	data[map.name] = deep_copy_dict_with_save(map.world_objs, map.world_objs_ref)
	


func deep_copy_dict_with_save(objs : Dictionary, refs : Dictionary):
	var copy = {}
	for k in objs:
		copy[k] = [objs[k], refs[k].save_data()]
	return copy