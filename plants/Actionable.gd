extends Area2D

class_name Actionable
var action_string = "Activate"

	
func apply_action(user):
	print(user.name + ": actioned")
