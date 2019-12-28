extends WorldObject

class_name PickableWorldObject

func _ready():
	ming = $Sprite.texture.resource_path.substr(20, len($Sprite.texture.resource_path)-24)



func right_clicked():
	remove_from_map()
	$AnimationPlayer.play("pick_up")
	sound_player.play_sound(16, self)
	
	

