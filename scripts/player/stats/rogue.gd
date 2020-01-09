extends Player

class_name Rogue

func _init():
	job = "Rogue"
	self.strength = 4
	self.intelligence = 4
	self.agility = 8
	self.luck = 4
	self.crit_multi = 225
	self.max_energy = 100
	update_stats()
	hp = self.max_hp
	mp = self.max_mp
	energy = self.max_energy 
	move_speed = 175
	xp = 0

func update_stats():
	self.max_hp = 250 + self.strength * 22 + level * (24 + level)
	self.max_mp = 225 + self.intelligence * (18 + level) + level * (10 * level)
	self.physical = 2 + self.strength * 2 + level * 2
	self.magical = 2 + self.intelligence * 2 + level * 2
	
	self.armor = 17 + self.strength * 4 + self.agility * 3
	self.resist = 17 + self.intelligence * 4 + self.agility * 3
	
	self.hit = 95 + int(self.agility / 5 + self.luck / 4)
	self.dodge = 4 + int(self.agility / 3 + self.luck / 5)
	self.crit = 5 + int(self.agility / 5 + self.luck / 5); 
	self.max_energy = 100
	self.max_xp = pow(self.level,2) + 13*self.level







