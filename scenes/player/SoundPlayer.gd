extends Node

var sounds = {}
var bgm = {}

func _ready():
	load_sounds("res://music/sound/", sounds)
	load_sounds("res://music/bgm/", bgm)


func load_sounds(path, dict):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i = 0
		while (file_name != ""):
			if dir.current_is_dir():
# warning-ignore:standalone_expression
				("Found directory: " + file_name)
			else:
				if file_name.ends_with(".import"): #export workaround for sound files
					var actual = file_name.replace(".import", "")
					dict[i] = load(path + actual)
					i+=1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func play_sound(id : int, node : Node, keep := true, on_player = false):
	var sfx := AudioStreamPlayer.new()
	sfx.set_stream(sounds[id])
	sfx.connect("finished",sfx,"queue_free")
	sfx.bus = "sound"
	sfx.volume_db = -10
	if keep:
		if on_player:
			get_tree().current_scene.player.add_child(sfx)
		else:
			node.add_child(sfx)
	else:
#		sfx.global_position = node.global_position
		get_tree().get_current_scene().add_child(sfx)
	sfx.play()

func get_bgm(id : int) -> AudioStream:
	return bgm[id]
