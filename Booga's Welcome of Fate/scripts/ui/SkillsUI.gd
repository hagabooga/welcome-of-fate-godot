extends Panel

func _process(delta):
	if !visible:
		$SkillTree.visible = false
		$SkillTree/MageFireTree/SkillDescPanel.visible = false
		$LearnedSkillsPanel._on_ExitLearnedSkills_Panel_pressed()

func _on_CloseButton_pressed():
	visible = !visible
	$SkillTree.visible = false

func _on_Fire_pressed():
	$SkillTree.visible = true
	$SkillTree/MageFireTree.visible = true

func _on_LearnedSkillsButton_pressed():
	$LearnedSkillsPanel.visible = true
