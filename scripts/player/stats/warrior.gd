extends Player

class_name Warrior

func _init():
	job = "Warrior"
	
	self.strength = 8
	self.intelligence = 3
	self.agility = 4
	self.luck = 5
	self.crit_multi = 225
	self.max_energy = 100
	update_stats()
	hp = self.max_hp
	mp = self.max_mp
	energy = self.max_energy 
	move_speed = 135
	xp = 0
	

func update_stats():
	self.max_hp = 350 + self.strength * 26 + level * (28 + level)
	self.max_mp = 125 + self.intelligence * (18 + level) + level * (8 * level)
	self.physical = 5 + self.strength * 3 + level * 3
	self.magical = 1 + self.intelligence + level * 2
	
	self.armor = 28 + self.strength * 5 + self.agility * 2
	self.resist = 10 + self.intelligence * 3 + self.agility * 2
	
	self.hit = 85 + int(self.agility / 6 + self.luck / 5)
	self.dodge = 0 + int(self.agility / 4 + self.luck / 6)
	self.crit = 4 + int(self.agility / 6 + self.luck / 6); 
	self.max_energy = 100
	self.max_xp = pow(self.level,2) + 13*self.level







