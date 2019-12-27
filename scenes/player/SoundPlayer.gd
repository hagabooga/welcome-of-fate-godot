extends Node

var sounds = {}

func _ready():
	load_sounds("res://music/sound/")


func load_sounds(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i = 0
		while (file_name != ""):
			if dir.current_is_dir():
				("Found directory: " + file_name)
			else:
				if file_name.ends_with(".import"): #export workaround for sound files
					var actual = file_name.replace(".import", "")
					sounds[i] = load("res://music/sound/" + actual)
					i+=1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func play_sound(id : int, node : Node):
	var sfx := AudioStreamPlayer2D.new()
	sfx.set_stream(sounds[id])
	sfx.connect("finished",sfx,"queue_free")
	node.add_child(sfx)
	sfx.play()
	