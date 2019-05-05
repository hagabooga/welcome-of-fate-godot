extends Actionable

class_name Npc

var info

func _ready():
	action_string = "Talk"
	info = npc_database.find_npc(name.to_lower())
	info["ming"] = name.to_lower()

func apply_action(user):
    user.start_dialogue(info)
