extends HBoxContainer

export(int) var type
var stats  = null

var used_ap : int = 0

func apply_increase():
	match type:
		0:
			stats.strength += used_ap
		1:
			stats.intelligence += used_ap
		2:
			stats.agility += used_ap
		3:
			stats.luck += used_ap

func update_amount():
	$Amount.text = "+%d"%used_ap
	
func show_increasers(yes):
	$Amount.visible = yes
	$Dec.visible = yes
	$Inc.visible = yes
	
func _on_Dec_pressed():
	if !used_ap:
		return
	stats.ap += 1
	used_ap -= 1
	$Inc.visible = true
	update_amount()
	get_parent().get_parent().find_node("AP").text = "AP: %d"%stats.ap
	sound_player.play_sound(41,self)

func _on_Inc_pressed():
	if !stats.ap:
		return
	stats.ap -= 1
	used_ap += 1
	update_amount()
	get_parent().get_parent().find_node("AP").text = "AP: %d"%stats.ap
	sound_player.play_sound(42,self)