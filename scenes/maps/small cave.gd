extends Map

var cave_level = 1

func _ready():
	print(cave_level)
	can_place = false
	$Hole.setup_hole()

func create_daily_objects():
	var occupied_cells = tilemap_soil.get_used_cells() + $TileMaps/Rocks.get_used_cells()
	for x in tilemap_dirt.get_used_cells():
		if not x in occupied_cells and randi()%10 == 0:
			create_world_object("ore", x)


func _on_Hole_body_entered(body):

	if body is Player:
		for x in $WorldObjects.get_children():
			x.destroy_and_remove_from_map()
		create_daily_objects()
