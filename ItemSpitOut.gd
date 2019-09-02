extends Node2D


var item_name : String

var first_x
var time_passed

func set_item(i):
	item_name = i
	$Sprite.texture = load("res://sprites/items/" +item_name+".png")


func _process(delta):
	if !$Timer.is_stopped():
		position.x += first_x

func play_spit_out(pos):
	global_position = pos
	first_x = rand_range(-0.5,0.5)
	$Timer.start()
	$AnimationPlayer.play("spit_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "spit_out":
		$AnimationPlayer.play("idle")


func _on_Area2D_area_entered(area):
	if area.name == "Hurtbox" and area.get_parent() is Player:
		area.get_parent().add_item(item_name)
		queue_free()
