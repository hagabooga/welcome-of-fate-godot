extends Node2D

class_name Map

var tilemap_grass
var tilemap_dirt
var tilemap_soil
var tilemap_soilObjects
var tilemap_worldObjects


func _ready():
	world_globals.current_map = self
	tilemap_grass = $TileMaps/Grass
	tilemap_dirt = $TileMaps/Dirt
	tilemap_soil = $TileMaps/Soil
	tilemap_soilObjects = $TileMaps/SoilObjects
	tilemap_worldObjects = $TileMaps/WorldObjects
	world_globals.create_world_objects()
	
func _process(delta):
	pass
	for x in $TileMaps.get_children():
		x.global_position = Vector2.ZERO