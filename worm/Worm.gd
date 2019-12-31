extends Enemy

func starting_stats() -> void:
	ming = "worm"
	self.max_hp = 85
	self.physical = 50
	item_drops = {"health potion": 20}