extends Node2D


func _ready():
	world_globals.tilemap_soil_objects = $TileMaps/SoilObjects
	world_globals.tilemap_soil = $TileMaps/Soil
	world_globals.plants_obj = $Plants




func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		world_globals.next_day()

func _on_WarpToInside_body_entered(body):
	body.global_position = $Objects/InsidePlayerHome/WarpPoint.global_position

func _on_WarpToOutsideHome_body_entered(body):
	body.global_position = $Objects/PlayerHome/WarpPoint.global_position
