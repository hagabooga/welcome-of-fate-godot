extends Node2D

var energy_cost = 0
var tool_anim = "slash"


func use():
	pass
	
					
func stop_anim():
	$AnimatedSprite.play("default")