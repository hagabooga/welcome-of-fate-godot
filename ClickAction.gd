class_name ClickAction

var action
var data
enum {NONE, ADD_ITEM, CREATE_QUESTION_BOX, OPEN_DIALOGUE, CONSUME, PLAY_ANIM}

func _init(a:=NONE,d = null):
	action = a
	data = d