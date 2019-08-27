extends Node2D

func create_question_box(question : String, target : Object, yes_func : String = "", no_func : String = ""):
	$QuestionBox.visible = true
	$QuestionBox/Question.text = question
	var buttons = [$QuestionBox/Buttons/YesButton, $QuestionBox/Buttons/NoButton]
	if yes_func != "":
		$QuestionBox/Buttons/YesButton.connect("pressed", target, yes_func)
	if no_func != "":
		pass
		#button_connect_and_delete($QuestionBox/NoButton, "pressed", target, no_func)
	for x in buttons:
		x.connect("pressed", $QuestionBox, "button_press")
		x.connect("pressed", $QuestionBox, "delete_all_button_connections", [x, "pressed"])
	#print($QuestionBox/YesButton.get_signal_connection_list("pressed"))

