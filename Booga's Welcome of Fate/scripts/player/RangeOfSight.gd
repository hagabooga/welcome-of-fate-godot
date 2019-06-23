extends Node2D

func _ready():
	$TargetIndicator/Sprite/AnimationPlayer.play("updown")

func _process(delta):
	var enemy = get_first_enemy() 
	if enemy != null:
		$TargetIndicator.visible = true
		$TargetIndicator.z_index = enemy.z_index + 1
		$TargetIndicator.global_position = enemy.find_node("AboveHeadPos").global_position
	else:
		$TargetIndicator.visible = false
	
func get_first_enemy():
	for x in $Range.get_overlapping_bodies():
		if x is Enemy:
			return x
	return null