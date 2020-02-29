extends Node

class_name SkillPoints


enum {WOODCUTTING, BUTCHER}

var points : Dictionary = {}

func _ready():
	points[WOODCUTTING] = Skill.new() # REWORD SKILL
