extends Panel

func _ready():
	_on_InProgButton_pressed()
	$Labels.visible = false
	visible = false

func add_quest(quest):
	$ItemPanel/InProgressQuests.add_item(quest.ming.capitalize())
	$ItemPanel/InProgressQuests.set_item_metadata($ItemPanel/InProgressQuests.get_item_count()-1, quest)

func get_quests(inprog):
	var items
	if inprog:
		items = $ItemPanel/InProgressQuests
	else:
		items = $ItemPanel/CompletedQuests
	var qs = []
	for i in range(items.get_item_count()):
		qs.append(items.get_item_text(i).to_lower())
	return qs
	

func set_quest_labels(quest):
	$Labels/Ming.text = quest.ming.capitalize()
	$Labels/Reward.text = quest.reward
	$Labels/Memory.text = quest.memory
	$Labels/Goals.text = ""
	var i = 0
	for x in quest.goals:
		if i == len(quest.goals) - 1:
			$Labels/Goals.text += "%s (%d/%d)"%[x.desc, x.did, x.need]
		else:
			$Labels/Goals.text += "%s (%d/%d)\n"%[x.desc, x.did, x.need]


func _on_InProgButton_pressed():
	$ItemPanel/InProgressQuests.visible = true
	$ItemPanel/CompletedQuests.visible = false
	$ItemPanel/InProgButton/Label.add_color_override("font_color", Color.white)
	$ItemPanel/CompletedButton/Label2.add_color_override("font_color", Color.black)
	$ItemPanel/CompletedQuests.unselect_all()
	$ItemPanel/InProgressQuests.unselect_all()
	$Labels.visible = false

func _on_CompletedButton_pressed():
	$ItemPanel/InProgressQuests.visible = false
	$ItemPanel/CompletedQuests.visible = true
	$ItemPanel/InProgButton/Label.add_color_override("font_color", Color.black)
	$ItemPanel/CompletedButton/Label2.add_color_override("font_color", Color.white)
	$ItemPanel/CompletedQuests.unselect_all()
	$ItemPanel/InProgressQuests.unselect_all()
	$Labels.visible = false

func _on_InProgressQuests_item_selected(index):
	var q = $ItemPanel/InProgressQuests.get_item_metadata(index)
	set_quest_labels(q)
	$Labels.visible = true


func _on_CompletedQuests_item_selected(index):
	var q = $ItemPanel/CompletedQuests.get_item_metadata(index)
	set_quest_labels(q)
	$Labels.visible = true
