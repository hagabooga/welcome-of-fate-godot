extends Player

class_name Mage

func _init():
	job = "Mage"
	self.strength = 3
	self.intelligence = 8
	self.agility = 4
	self.luck = 5
	self.crit_multi = 225
	self.max_energy = 100
	update_stats()
	hp = self.max_hp
	mp = self.max_mp
	energy = self.max_energy 
	move_speed = 150

func update_stats():
	self.max_hp = 225 + self.strength * 28 + level * (32 + level)
	self.max_mp = 475 + self.intelligence * (35 + level) + level * (55 * level)
	self.physical = 35 + self.strength + level * 3
	self.magical = 70 + self.intelligence * 8 + level * 9
	
	self.armor = 15 + self.strength * 4 + self.agility * 2
	self.resist = 25 + self.intelligence * 5
	
	self.hit = 90 + int(self.agility / 6 + self.luck / 5)
	self.dodge = 1 + int(self.agility / 4 + self.luck / 6)
	self.crit = 2 + int(self.agility / 6 + self.luck / 6); 
	self.max_energy = 100

