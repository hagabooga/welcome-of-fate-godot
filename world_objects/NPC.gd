extends WorldObject

class_name NPC

export(String) var mingzi
export(Array, String) var quests
var info : Dictionary


func _ready():
	info = npc_database.find_npc(mingzi)
	ming = mingzi


func right_clicked() -> Array:
	return [ClickAction.new(ClickAction.OPEN_DIALOGUE, [ming, info])]


func _on_LeaveArea_body_exited(body):
	if body is Player:
		body.close_dialogue()
