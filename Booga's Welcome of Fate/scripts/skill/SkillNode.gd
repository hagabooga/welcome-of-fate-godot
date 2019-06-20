extends Panel

var skill

func _ready():
	skill = skill_database.make_skill(name.to_lower())
	$TextureButton.texture_normal = load("res://sprites/skills/%s.png"%name.to_lower())
	update_rank_label()
	
func update_rank_label():
	$Rank.text = "%d / %d"%[skill.rank,skill.max_rank]

func _on_TextureButton_pressed():
	rank_up()
	get_parent().get_parent().mouse_enter_skill_node(self)

func rank_up():
	if skill.rank == 0:
		player_skills.learned_skills.append(skill)
		player_skills.emit_signal("skill_learned", self)
	if skill.rank != skill.max_rank:
		skill.rank += 1
		update_rank_label()
		player_skills.emit_signal("skill_changed")
		