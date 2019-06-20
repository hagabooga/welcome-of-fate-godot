extends TextureRect

var skill
func set_skill(s):
	skill = s
	get_child(0).texture = load("res://sprites/skills/%s.png"%s.ming.to_lower())

func activate_skill():
	skill_activations.activate_skill(skill)