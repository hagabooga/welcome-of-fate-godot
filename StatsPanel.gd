extends Panel


var stats

var increasers = []


func _ready():
	increasers.append($VBoxContainer/StatIncreaser)
	increasers.append($VBoxContainer/StatIncreaser2)
	increasers.append($VBoxContainer/StatIncreaser3)
	increasers.append($VBoxContainer/StatIncreaser4)

func able_use_ap():
	for x in increasers:
		x.show_increasers(true)
	$ApplyButton.visible = true
	update_text()

func set_stats(s : Attributes):
	stats = s
	for x in increasers:
		x.stats = s

func update_text():
	$AP.text = "AP: %d"%stats.ap
	$VBoxContainer/Name.text = "Name: " + stats.ming
	$VBoxContainer/Level.text = "Level: %d"%stats.level
	$VBoxContainer/Job.text = "Class: " + stats.job
	for i in range(3, $VBoxContainer.get_child_count()):
		var label = $VBoxContainer.get_child(i) 
		if 3 <= i and i < 7:
			label = label.get_child(0)
		var x = stats.stats[i-3]
		if int(x.final_val) == x.final_val:
			label.text = "%s: %d"%[global_id.stat_idToName[x.type].capitalize(),x.final_val]
		else:
			label.text = "%s: %.1f"%[global_id.stat_idToName[x.type].capitalize(),x.final_val]
		#label.add_color_override("font_color", global_id.stat_idToColor[x.type])

func _on_ApplyButton_pressed():
	for x in increasers:
		x.apply_increase()
		x.used_ap = 0
		x.update_amount()
	if stats.ap == 0:
		for x in increasers:
			x.show_increasers(false)
		$ApplyButton.visible = false
	sound_player.play_sound(43,self)