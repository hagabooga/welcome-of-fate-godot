extends Enemy

func starting_stats() -> void:
	ming = "Gator"
	self.max_hp = 100
	self.physical = 25
	item_drops = {"gator skin": 50}
