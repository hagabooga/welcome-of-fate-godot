extends Sprite

class_name SpriteWithBodyAnimation
var current_dir
var current_anim = "idle"
enum {up,down,left,right}

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

func play_anim(anim, dir, speed_ratio = 8):
	current_dir = dir
	current_anim = anim
	$AnimationPlayer.play("%s_%s"%[anim,dir_to_string(dir)])
	$AnimationPlayer.playback_speed = speed_ratio


