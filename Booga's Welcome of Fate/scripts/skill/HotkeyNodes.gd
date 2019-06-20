extends HBoxContainer

func _ready():
	for x in range(12):
		get_child(x).get_child(0).texture = null
		
func _process(delta):
	if Input.is_action_just_pressed("skill0"):
		get_child(0).activate_skill()
	
func map_skill(index, skill):
	get_child(index).set_skill(skill)