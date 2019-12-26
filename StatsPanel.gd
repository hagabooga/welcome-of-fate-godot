extends Panel


var stats

var increasers = []


func _ready():
	increasers.append($VBoxContainer/StatIncreaser)
	increasers.append($VBoxContainer/StatIncreaser2)
	increasers.append($VBoxContainer/StatIncreaser3)
	increasers.append($VBoxContainer/StatIncreaser4)

func able_use_ap():
	$ApplyButton.visible = true
	update_text()

func set_stats(s : Attributes):
	stats = s
	for x in increasers:
		x.stats = s

func update_text():
	$AP.text = "AP: %d"%stats.ap
	$VBoxContainer/Name.text = "Name: " + stats.name
	$VBoxContainer/Level.text = "Level: %d"%stats.level
	for i in range(2, $VBoxContainer.get_child_count()):
		var label = $VBoxContainer.get_child(i) 
		if 2 <= i and i < 6:
			label = label.get_child(0)
		var x = stats.stats[i-2]
		label.text = "%s: %d"%[global_id.stat_idToName[x.type].capitalize(),x.final_val]
		#label.add_color_override("font_color", global_id.stat_idToColor[x.type])

func _on_ApplyButton_pressed():
	for x in increasers:
		x.apply_increase()
		x.used_ap = 0
		x.update_amount()
	if stats.ap == 0:
		for x in increasers:
			x.hide_increasers()
		$ApplyButton.visible = false
			
			
			