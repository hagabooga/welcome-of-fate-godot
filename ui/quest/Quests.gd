extends Panel

class_name QuestsUI

var quest_ui_button = preload("res://ui/quest/QuestUIButton.tscn")

var quests = {}
var completed = {}
var showing_quest = null


func add_quest(q : Quest):
	var tr  = quest_ui_button.instance()
	tr.text = q.ming.capitalize()
	tr.quest = q
	tr.connect("pressed", self, "show_details", [q, true])
	quests[q.ming] = tr
	$InProgress/VBoxContainer.add_child(tr)

func complete_quest(ming : String):
	var quest_button = quests[ming]
	#print(quest_button)
	$InProgress/VBoxContainer.remove_child(quest_button)
	$Completed/VBoxContainer.add_child(quest_button)
	completed[ming] = quest_button
	quests.erase(ming)
	#print(completed[ming])


func show_details(q : Quest, play_sound = false):
	showing_quest = q
	$VBoxContainer/Ming.text = q.ming.capitalize()
	var s = "Goals:\n"
	var l = len(q.goals)
	for x in range(l):
		var goal = q.goals[x]
		s += "- " + goal.desc + " (%d/%d)"%[goal.did,goal.need] + ("\n" if x != l - 1 else "") 
	$VBoxContainer/Goals.text = s
	$VBoxContainer/Memory.text = q.memory # "[i]%s[/i]"
	if play_sound:
		sound_player.play_sound(43, self, true, true)

func _on_InProgressButton_pressed():
	$Which.text = "In Progress"
	$Completed.visible = false
	$InProgress.visible = true
	$CompletedLabel.visible = false
	sound_player.play_sound(43, self, true, true)
	clear_details()
	
func _on_Completed_pressed():
	$Which.text = "Completed"
	$Completed.visible = true
	$InProgress.visible = false
	$CompletedLabel.visible = true
	sound_player.play_sound(43, self, true, true)
	clear_details()

func clear_details():
	$VBoxContainer/Ming.text = ""
	$VBoxContainer/Goals.text = ""
	$VBoxContainer/Memory.text = ""
	
func check_kill_goal(ming : String):
	for quest in quests:
		for goal in quests[quest].quest.goals:
			if goal.type == 0 and goal.object_ming == ming:
				goal.did += 1
				if showing_quest != null:
					show_details(showing_quest)

