extends Sprite

class_name PlayerBaseSprite

var actions = ["cast","thrust","walk","slash", "bow", "die"]
var action_max_frame = {"cast":7,"thrust":8,"walk":9,"slash":6, "bow":13, "die":6}
enum {up,left,down,right}
var current_action = "walk"
var current_direction = down
var current_action_frame = 0
var playing = false
var anim_speed = 8
var fps = 0
var play_once = false

signal anim_finished

func _process(delta):
	if playing:
		if fps <= 0:
			next_frame()
		else:
			fps -= delta

func play_action_anim(action, dir, once = false):
	if action != current_action or dir != current_direction:
		play_once = once
		playing = true
		fps = 0
		current_action = action
		current_direction = dir
		current_action_frame = 1
		
func play_idle(dir):
	frame = dir*13
	current_action = "idle"
	current_direction = dir
	playing = false

func next_frame():
	current_action_frame += 1
	if current_action_frame == action_max_frame[current_action]:
		if play_once:
			playing = false
			emit_signal("anim_finished")
			return
		current_action_frame = 1
	frame = actions.find(current_action)*13*4 + current_direction*13 + current_action_frame
	fps = float(1)/anim_speed