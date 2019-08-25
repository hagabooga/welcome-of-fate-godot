extends CollisionObject2D

class_name Clickable

signal clicked

var tile_pos : Vector2 setget set_tile_pos


func set_tile_pos(pos : Vector2):
	tile_pos = pos

func clicked(tewl : Tool):
	pass