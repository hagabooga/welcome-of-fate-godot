extends Node2D

func setup_hole():
	var p1 = $HoleArea.global_position
	var p2 = p1 + $HoleArea/CollisionShape2D.shape.extents * 2
	var tilemap = get_parent().find_node("TileMaps").get_child(0)
	$Hole.global_position = tilemap.map_to_world(tilemap.world_to_map(
		Vector2(rand_range(p1.x, p2.x),rand_range(p1.y, p2.y))))



