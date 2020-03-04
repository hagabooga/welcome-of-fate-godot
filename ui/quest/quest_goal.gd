extends Node

class_name QuestGoal

var object_ming
var did
var need
var type
var desc

## monster: 0 , item: 1
func _init(x):
	object_ming = x[0]
	did = 0
	need = x[1]
	type = x[2]
	desc = x[3]
	print(need)

func is_complete():
	return did >= need
