extends TextureRect

var skill_node = null

func _process(delta):
	if skill_node != null:
		if $SkillImage/Cooldown.value >= 0:
			$SkillImage/Cooldown.value = 100 * (skill_node.cooldown_left/skill_node.skill.cooldown)

func set_skill(s):
	skill_node = s
	get_child(0).texture = load("res://sprites/skills/%s.png"%s.skill.ming.to_lower())

func activate_skill():
	if (skill_node != null and skill_node.can_activate()):
		if (world_globals.player.use_skill(skill_node.skill)):
			skill_node.go_on_cooldown()
			$SkillImage/Cooldown.value = $SkillImage/Cooldown.max_value
