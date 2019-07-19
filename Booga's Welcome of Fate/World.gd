extends Node2D

func _ready():
	world_globals.world = self
	world_globals.tilemap_soil_objects = $TileMaps/SoilObjects
	world_globals.tilemap_soil = $TileMaps/Soil
	world_globals.plants_obj = $Plants
	world_globals.tilemap_grass = $TileMaps/Grass
	world_globals.tilemap_world_objects = $TileMaps/WorldObjects
	world_globals.tilemap_dirt = $TileMaps/Dirt
	#world_globals.create_world_objects()
	


func _process(delta):
	$TileMaps/WorldObjects.global_position = Vector2.ZERO
	if Input.is_action_just_pressed("ui_cancel"):
		world_globals.next_day()

func _on_WarpToInside_body_entered(body):
	body.global_position = $Objects/InsidePlayerHome/WarpPoint.global_position

func _on_WarpToOutsideHome_body_entered(body):
	body.global_position = $Objects/PlayerHome/WarpPoint.global_position
