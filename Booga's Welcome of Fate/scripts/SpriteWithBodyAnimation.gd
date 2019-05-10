extends Sprite

class_name SpriteWithBodyAnimation
var current_dir
enum {up,left,down,right}

func dir_to_string(dir):
	match dir:
		up:
			return "up"
		left:
			return "left"
		down:
			return "down"
		right:
			return "right"

func play_anim(anim, dir):
	current_dir = dir
	$AnimationPlayer.play("%s_%s"%[anim,dir_to_string(dir)])