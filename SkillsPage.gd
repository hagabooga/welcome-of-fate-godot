extends Panel

var player : Attributes

var sp : int = 0 setget set_sp
var learned_skills = []
signal on_skill_learned(skill)
signal on_skill_changed


func _ready():
	player = get_parent().get_parent().get_parent()
	self.sp = 0
	connect("on_skill_learned", self, "learn_skill")
	connect("on_skill_changed", self, "update_skills")
	update_skills()


func set_sp(val):
	sp = val
	$SP.text = "SP: %d"%sp
	
func learn_skill(skill : Skill):
	learned_skills.append(skill)
	emit_signal("on_skill_changed")
	
func update_skills():
	for x in learned_skills:
		match x.ming:
			"fireball":
				x.damage = 75 + 25 * x.rank + player.intelligence * (16 + 18*x.rank)
				x.mana = 100 + x.rank * 50
				x.cooldown = 1.25
			"summon fire lion":
				x.damage = 250
				x.mana = 150
				x.cooldown = 2
			"torrentacle":
				x.damage = 75
				x.mana = 100
				x.cooldown = 3

func _on_CloseButton_pressed():
	visible = false
	
