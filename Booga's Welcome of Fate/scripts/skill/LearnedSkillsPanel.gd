extends Panel

var current_selected = null
var hotkey_skills_ui

func _ready():
	hotkey_skills_ui = get_parent().get_parent().find_node("HotkeyNodes")
	player_skills.connect("skill_learned",self, "learn_skill")
	var hotkeys = $SkillStuff/PickHotkey/HotkeySelections
	for x in range(hotkeys.get_child_count()):
		hotkeys.get_child(x).connect("pressed",self,"hotkey_map_press",[x])

func hotkey_map_press(x):
	hotkey_skills_ui.map_skill(x, $LearnedSkills.get_item_metadata(current_selected).skill)


func learn_skill(node):
	$LearnedSkills.add_icon_item(load("res://sprites/skills/%s.png"%node.skill.ming.to_lower()))
	$LearnedSkills.set_item_metadata($LearnedSkills.get_item_count() - 1, node)


func _on_LearnedSkills_item_selected(index):
	$SkillStuff/Labels.set_labels($LearnedSkills.get_item_metadata(index).skill)
	current_selected = index
	$SkillStuff/Hotkey.visible = true
	$SkillStuff/Labels.visible = true

func _on_LearnedSkills_item_activated(index):
	var node = $LearnedSkills.get_item_metadata(index)
	node.rank_up()


func _on_HotkeyButton_pressed():
	$SkillStuff/PickHotkey.visible = true


func _on_HotkeyCancel_pressed():
	$SkillStuff/PickHotkey.visible = false


func _on_ExitLearnedSkills_Panel_pressed():
	visible = false
	$LearnedSkills.unselect_all()
	$SkillStuff/Hotkey.visible = false
	$SkillStuff/Labels.visible = false
	