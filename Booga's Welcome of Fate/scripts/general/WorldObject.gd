extends Node2D

var tile_pos : Vector2 setget set_tile_pos


func set_tile_pos(pos : Vector2):
	tile_pos = pos
	
func set_texture(path):
	$Sprite.texture = load(path)
