extends Node

class_name Collectibles


enum {WOODCUTTING, BUTCHER}

var collectibles : Dictionary


func get_collectible(id : int) -> Collectible:
	return collectibles[id]
