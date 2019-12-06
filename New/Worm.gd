extends Enemy

func starting_stats() -> void:
	ming = "Worm"
	self.max_hp = 350
	self.physical = 15
	item_drops = {"health potion": 75}