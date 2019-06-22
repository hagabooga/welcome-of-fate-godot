extends HBoxContainer

var input_keys = []

func _ready():
	for x in range(12):
		input_keys.append("skill" + str(x))
		get_child(x).get_child(0).texture = null
		get_child(x).get_child(0).get_child(0).value = 0
		
func _process(delta):
	var i = 0
	for x in input_keys:
		if Input.is_action_just_pressed(x):
			get_child(i).activate_skill()
		i += 1
	
func map_skill(index, skill):
	get_child(index).set_skill(skill)