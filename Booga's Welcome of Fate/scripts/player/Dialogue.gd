extends Panel

var arrow = load("res://Arrow Right.png")

var current_info
var showing_dialogue
var current_dialogue
var dialogue_pos

func _ready():
	$DialogueText/TextureRect/AnimationPlayer.play("moving")

func _process(delta):
	if (showing_dialogue):
		if (Input.is_action_just_pressed("ui_accept")):
			if dialogue_pos == len(current_dialogue):
				close_dialogue()
			dialogue_pos += 1

func make_dialogue_options(info):
	$Options.visible = true
	current_info = info
	$Options.clear()
	$Options.add_item("Talk",arrow)
	$Options.add_item("Exit",arrow)
	$Options.select(0)
	$Options.grab_focus()


func create_dialogue():
	$Options.clear()
	$Options.visible = false
	current_dialogue = current_info.default
	dialogue_pos = 0
	set_dialogue()
	showing_dialogue = true
	$DialogueText.visible = true

func set_dialogue():
	$DialogueText.text = current_dialogue[dialogue_pos]
	


func _on_Options_item_activated(index):
	var option = $Options.get_item_text(index)
	if option == "Talk":
		create_dialogue()
	elif option == "Exit":
		close_dialogue()
		
func close_dialogue():
	visible = false
	showing_dialogue = false
	$DialogueText.visible = false