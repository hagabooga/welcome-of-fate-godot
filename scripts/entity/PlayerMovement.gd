extends Node

enum {up,down,left,right}
var facing

var velocity = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		velocity = Vector2.UP
	
