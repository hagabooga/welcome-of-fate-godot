extends Panel

var arrow_texture = load("res://sprites/ui/Arrow Right.png")

var current_info
var showing_dialogue = false
var current_dialogue
var dialogue_pos
var asking_quest = false
var quest_item_index
var can_next_dialogue = false

func _ready():
	$DialogueText/TextureRect/AnimationPlayer.play("moving")

func _process(delta):
	if $Timer.time_left > 0:
		visible = false
	elif (showing_dialogue and can_next_dialogue):
		if Input.is_action_just_pressed("z"):
			print(dialogue_pos)
			dialogue_pos += 1
			if dialogue_pos <= len(current_dialogue) - 1:
				if asking_quest and dialogue_pos == len(current_dialogue) - 1:
					show_quest_ask()
				set_dialogue()
			else:
				close_dialogue()

func make_dialogue_options(info):
	if (!$Timer.time_left > 0):
		$Options/Timer.start()
		$Options.visible = true
		current_info = info
		$Options.clear()
		$Options.add_item("Talk",arrow_texture)
		for x in current_info.quests:
			var compq = get_parent().find_node("Quests").get_quests(false)
			if not x in compq:
				var q = Quest.new(current_info.ming, x)
				$Options.add_item("Quest", arrow_texture)
				$Options.set_item_metadata($Options.get_item_count()-1, q)
		$Options.add_item("Exit",arrow_texture)
		$Options.select(0)
		$Options.grab_focus()


func create_dialogue(text):
	$Options.visible = false
	current_dialogue = text
	dialogue_pos = 0
	set_dialogue()
	showing_dialogue = true
	$DialogueText.visible = true

func show_quest_ask():
	can_next_dialogue = false
	var q = $Options.get_item_metadata(quest_item_index)
	$QuestAsk.visible = true
	$QuestAsk/VBoxContainer/Name.text = q.ming.capitalize()
	$QuestAsk/VBoxContainer/Reward.text = q.reward
	$QuestAsk/VBoxContainer/Objective.text = ""
	for x in q.goals:
		$QuestAsk/VBoxContainer/Objective.text += x.desc
		

func set_dialogue():
	$DialogueText.text = current_dialogue[dialogue_pos]
	

func _on_Options_item_activated(index):
	var option = $Options.get_item_text(index)
	can_next_dialogue = true
	if option == "Talk":
		create_dialogue(current_info.default)
	elif option == "Quest":
		var meta = $Options.get_item_metadata(index)
		if meta.ming in get_parent().find_node("Quests").get_quests(true):
			create_dialogue(meta.in_prog)
		else:
			asking_quest = true
			quest_item_index = index
			create_dialogue(meta.ask)
	elif option == "Exit":
		close_dialogue()
		
		
func close_dialogue():
	can_next_dialogue = false
	visible = false
	showing_dialogue = false
	$DialogueText.visible = false
	get_parent().can_open_ui = true
	$Timer.start()

func _on_QuestYes_pressed():
	var q = $Options.get_item_metadata(quest_item_index)
	create_dialogue(q.accept)
	quest_ask_button_press()
	get_parent().find_node("Quests").add_quest(q)


func _on_QuestNo_pressed():
	var q = $Options.get_item_metadata(quest_item_index)
	create_dialogue(q.decline)
	quest_ask_button_press()


func quest_ask_button_press():
	dialogue_pos = 0
	$QuestAsk.visible = false
	can_next_dialogue = true
	asking_quest = false
	

