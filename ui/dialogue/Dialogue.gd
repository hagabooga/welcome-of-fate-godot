extends Panel
class_name DialogueUI

var option = preload("res://ui/dialogue/DialogueOption.tscn")

var npc_options
enum {QUEST, TALK, CLOSE}

var dialogue
var index = 0 setget set_index
var current_quest : Quest = null
var asking = false

func set_index(val):
	index = val
	if index != 0:
		if index > len(dialogue) - 1:
			if current_quest == null:
				close()
				return
		if asking and index == len(dialogue) - 1:
			show_quest_accept()
		elif not asking and current_quest != null:
			close()
	#index = 0
	#dialogue = current_quest
	$DialogueText.text = dialogue[index]

func show_quest_accept():
	asking = false
	$Button.visible = false
	$QuestAccept.visible = true
	$QuestAccept/Name/Label.text = current_quest.ming.capitalize()
	var s =  "Objectives\n"
	var length = len(current_quest.goals)
	for i in range(length):
		s += "- " + current_quest.goals[i].desc + ("\n" if i != length - 1  else "")
	$QuestAccept/Objectives/Label.text = s
	$QuestAccept/Reward/Label.text = "Reward\n" + current_quest.reward
	

func _ready():
	$AnimationPlayer.play("move_arrow")

func create_option(t, c):
	var opt = option.instance()
	opt.text = t.capitalize()
	opt.connect("pressed", self, "option_press", [t, c])
	$DialogueText/GridContainer.add_child(opt)
	
func option_press(t, c):
	match c:
		CLOSE: close()
		TALK: start_dialogue(npc_options["default"])
		QUEST: 
			start_quest(Quest.new(name.capitalize(),t))
			

func close():
	visible = false
	current_quest = null

func set_dialogue(npc_name:String, info : Dictionary):
	for x in $DialogueText/GridContainer.get_children(): x.queue_free()
	if len(info) <= 0:
		return
	$Name/Label.text = npc_name.capitalize()
	$DialogueText.text = ""
	visible = true
	$Button.visible = false
	$DialogueText/GridContainer.visible = true
	npc_options = info
	for x in info:
		match x:
			"quests":
				for quest in info[x]: create_option(quest, QUEST)
			"default": create_option("Talk", TALK)
	create_option("Close", CLOSE) 

func start_quest(q : Quest):
	if q.ming in get_parent().quest.quests:
		var quest = get_parent().quest.quests[q.ming].quest
		if quest.is_all_goals_completed():
			get_parent().quest.complete_quest(q.ming)
			get_parent().get_parent().get_parent().add_xp(50)
			get_parent().get_parent().get_parent().add_cash(500)
			start_dialogue(q.complete)
		else:
			start_dialogue(q.in_prog)
	elif q.ming in get_parent().quest.completed:
		start_dialogue(q.complete)
	else:
		current_quest = q
		asking = true
		start_dialogue(current_quest.ask)



func start_dialogue(d : Array):
	$Button.visible = true
	$DialogueText/GridContainer.visible = false
	dialogue = d
	self.index = 0


func _on_Button_pressed():
	self.index += 1


func _on_QuestYes_pressed():
	$QuestAccept.visible = false
	get_parent().quest.add_quest(current_quest)
	start_dialogue(current_quest.accept)
	current_quest = null


func _on_QuestNo_pressed():
	$QuestAccept.visible = false
	start_dialogue(current_quest.decline)
	current_quest = null
	
