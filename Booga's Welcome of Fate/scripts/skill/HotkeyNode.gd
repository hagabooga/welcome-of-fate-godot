extends TextureRect

var skill

var cooldown_left = 0

func _process(delta):
	if (cooldown_left >= 0):
		cooldown_left -= delta


func set_skill(s):
	skill = s
	get_child(0).texture = load("res://sprites/skills/%s.png"%s.ming.to_lower())

func activate_skill():
	if cooldown_left < 0:
		skill_activations.activate_skill(skill)
		cooldown_left = skill.cooldown