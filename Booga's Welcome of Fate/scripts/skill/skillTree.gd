extends Panel

var looking_skill = false

func _ready():
	$SkillDescPanel.visible = false
	for i in range($Skills.get_child_count()):
		$Skills.get_child(i).connect("mouse_entered", self, "mouse_enter_skill_node", [$Skills.get_child(i)])
		$Skills.get_child(i).connect("mouse_exited", self, "mouse_exit_skill_node", [$Skills.get_child(i)])

func _process(delta):
	if looking_skill:
		var pos = get_global_mouse_position()
		pos.x -= $SkillDescPanel.rect_size.x
		$SkillDescPanel.rect_global_position = pos

func mouse_enter_skill_node(x):
	looking_skill = true
	$SkillDescPanel.visible = true
	var s = x.skill
	$SkillDescPanel/Labels/Ming.text = s.ming.capitalize()
	$SkillDescPanel/Labels/Rank.text = "Rank: (%d / %d)"%[s.rank, s.max_rank]
	$SkillDescPanel/Labels/Desc.text = s.desc
	$SkillDescPanel/Labels/Detail.text = ""
	if s.rank == 0:
		$SkillDescPanel/Labels/Detail.text = "\nSkill not yet learned!"
	else:
		$SkillDescPanel/Labels/Detail.text += "\nDamage: %d"%s.damage
		$SkillDescPanel/Labels/Detail.text += "\nMana Cost: %d"%s.mana
		$SkillDescPanel/Labels/Detail.text += "\nCooldown: %ds"%s.cooldown
		
	
func mouse_exit_skill_node(x):
	looking_skill = false
	$SkillDescPanel.visible = false
	

func _on_CloseButton_pressed():
	visible = false

