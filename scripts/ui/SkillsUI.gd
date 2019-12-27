extends Panel

func _ready():
	for x in range($Elements.get_child_count()):
		var elem = $Elements.get_child(x)
		elem.connect("pressed", self, "open_skill_tree", [elem.name])

func _process(delta):
	if !visible:
		$SkillTree.visible = false
		$LearnedSkillsPanel._on_ExitLearnedSkills_Panel_pressed()

func _on_CloseButton_pressed():
	visible = !visible
	$SkillTree.visible = false

func _on_LearnedSkillsButton_pressed():
	$LearnedSkillsPanel.visible = true

func open_skill_tree(type):
	$SkillTree.visible = true
	for x in range($SkillTree.get_child_count()):
		$SkillTree.get_child(x).visible = false
	if $SkillTree.find_node(type) != null:
		$SkillTree.find_node(type).visible = true
	
	
	
	
	
	
	
	
	
	
	
	