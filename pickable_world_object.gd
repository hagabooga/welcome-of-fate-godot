extends WorldObject

class_name PickableWorldObject

func _ready():
	ming = $Sprite.texture.resource_path.substr(20, len($Sprite.texture.resource_path)-24)

func right_clicked():
	$AnimationPlayer.play("pick_up")
	