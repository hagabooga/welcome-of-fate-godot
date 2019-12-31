extends Player

class_name Mage

func _init():
	job = "Mage"
	self.strength = 3
	self.intelligence = 8
	self.agility = 5
	self.luck = 4
	self.crit_multi = 225
	self.max_energy = 100
	update_stats()
	hp = self.max_hp
	mp = self.max_mp
	energy = self.max_energy 
	move_speed = 150
	xp = 0

func update_stats():
	self.max_hp = 175 + self.strength * 18 + level * (20 + level)
	self.max_mp = 300 + self.intelligence * (26 + level) + level * (12 * level)
	self.physical = 1 + self.strength + level * 2
	self.magical = 6 + self.intelligence * 2 + level * 3
	
	self.armor = 15 + self.strength * 4 + self.agility * 2
	self.resist = 25 + self.intelligence * 5 + self.agility * 2
	
	self.hit = 90 + int(self.agility / 6 + self.luck / 5)
	self.dodge = 1 + int(self.agility / 4 + self.luck / 6)
	self.crit = 2 + int(self.agility / 6 + self.luck / 6); 
	self.max_energy = 100
	self.max_xp = pow(self.level,2) + 13*self.level







