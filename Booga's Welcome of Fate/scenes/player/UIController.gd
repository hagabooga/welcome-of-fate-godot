extends Node2D

func create_question_box(question : String):
	$QuestionBox.visible = true
	$QuestionBox/Question.text = question
	

