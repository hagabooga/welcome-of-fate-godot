extends Node

var data = {}

func add_map_data(map: Map):
	data[map.name] = deep_copy_dict_with_save(map)

func deep_copy_dict_with_save(map: Map):
	var copy = {}
	for k in map.world_objs:
		copy[k] = [map.world_objs[k], map.world_objs_ref[k].save_data()]
	copy["TilledSoil"] = {}
	for tilledsoil in map.tilled_soil_objs:
		copy["TilledSoil"][tilledsoil.tile_pos] = tilledsoil.save_data()
	return copy


func clear_data():
	data = {}
