extends Node

class_name Quest

var ming
var npc
var ask
var accept
var decline
var in_prog
var complete

var reward
var memory
var goals

func _init(npc_ming, x):
	var q = quest_database.find_quest(x)
	ming = x
	npc = npc_ming
	ask = q.ask
	accept = q.accept
	decline = q.decline
	in_prog = q.in_prog
	complete = q.complete
	reward = q.reward
	memory = q.memory
	goals = []
	for x in q.goals:
		var goal = QuestGoal.new(x)
		goals.append(goal)
#	for x in goals:
#		print(x.object_ming)
	
	

