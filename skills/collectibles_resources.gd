extends Collectibles

class_name CollectibleResources

func _init():
	collectibles[WOODCUTTING] = Collectible.new("woodcutting",\
	"%d%% chance to obtain double the amount of planks when cutting branches.", 20, 2, 10)
	collectibles[BUTCHER] = Collectible.new("butcher",\
	"%d%% chance to obtain double the amount of meat when killing an animal.", 20, 2, 10)
