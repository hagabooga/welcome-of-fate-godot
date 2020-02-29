extends Collectibles

class_name CollectibleResources

func _init():
	print("YO")
	collectibles[WOODCUTTING] = Collectible.new("woodcutting", """%d%% chance to obtain double the amount
	of planks when cutting branches.""", 10, 2, 10)
	collectibles[BUTCHER] = Collectible.new("butcher","""%d%% chance to obtain double the amount
	of meat when killing an animal.""", 10, 2, 10)
