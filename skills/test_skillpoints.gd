extends Node

var collectibles

func _ready():
	collectibles = CollectibleResources.new()


func _process(delta):
	if Input.is_action_just_pressed("ctrl"):
		collectibles.get_collectible(Collectibles.BUTCHER).add_point()
#		print(collectibles.get_collectible(Collectibles.BUTCHER).points)
