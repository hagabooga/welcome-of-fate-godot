tool
extends TileMap



func _process(delta):
	if len(get_used_cells_by_id(1)) != len(get_used_cells_by_id(6)):
		for x in get_used_cells_by_id(1):
			set_cellv(x + Vector2(0,2), 6)
	print(1)
