extends Enemy

func starting_stats() -> void:
	ming = "Worm"
	self.max_hp = 65
	self.physical = 20
	item_drops = {"health potion": 5}