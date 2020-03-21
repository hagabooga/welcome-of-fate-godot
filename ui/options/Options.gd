extends Panel

var resolutions = [
	Vector2(896,504),
	Vector2(1024,576),
	Vector2(1152,648),
	Vector2(1280,720),
	Vector2(1408,792),
	Vector2(1526, 864),
	Vector2(1664, 936),
	Vector2(1792, 1008),
	
]

func _ready():
	for i in range(len(resolutions)):
		var data = resolutions[i] 
		$VBoxContainer/Resolutions.add_item(str(data), i)
		$VBoxContainer/Resolutions.set_item_metadata(i, data)
	$VBoxContainer/Resolutions.select(1)
	var data = $VBoxContainer/Resolutions.get_item_metadata(1)
	OS.window_size = data
		
func _on_Resolutions_item_selected(ID):
	var data = $VBoxContainer/Resolutions.get_item_metadata(ID)
	OS.window_size = data
	sound_player.play_sound(43, self, true, true)

func _on_FullscreenToggle_pressed():
	var full = !OS.window_fullscreen
	OS.window_fullscreen = full
	$VBoxContainer/Resolutions.disabled = full
	sound_player.play_sound(43, self, true, true)

func _on_VolumeToggle_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !$VBoxContainer/VolumeToggle.pressed)
	$VBoxContainer/VolumeSlider.editable = $VBoxContainer/VolumeToggle.pressed
	sound_player.play_sound(43, self, true, true)
	
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_BGMToggle_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("bgm"), !$VBoxContainer/BGMToggle.pressed)
	$VBoxContainer/BGMSlider.editable = $VBoxContainer/BGMToggle.pressed
	sound_player.play_sound(43, self, true, true)


func _on_BGMSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), value)
	
	
func _on_SoundToggle_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("sound"), !$VBoxContainer/SoundToggle.pressed)
	$VBoxContainer/SoundSlider.editable = $VBoxContainer/SoundToggle.pressed
	sound_player.play_sound(43, self, true, true)


func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sound"), value)
	


func _on_PauseToggle_pressed():
	get_tree().paused = !get_tree().paused

func _on_CloseButton_pressed():
	visible = !visible
	sound_player.play_sound(43, self, true, true)


func _on_InstructionsButton_pressed():
	$Instructions.visible = true
#	var save_game = File.new()
#	save_game.open("user://savegame.save", File.READ)
#	var dx = parse_json(save_game.get_line())["Worm Desert"]
#	for x in dx.keys():
#		print(dx[x][1][0][0].ming)
	sound_player.play_sound(43, self, true, true)
	

func _on_SaveButton_pressed():
	sound_player.play_sound(43, self, true, true)
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(map_data.data))
	save_game.close()

