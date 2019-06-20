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
	$SkillDescPanel/Labels.set_labels(s)
	
func mouse_exit_skill_node(x):
	looking_skill = false
	$SkillDescPanel.visible = false
	

func _on_CloseButton_pressed():
	visible = false

