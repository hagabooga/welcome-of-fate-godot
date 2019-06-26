extends Enemy

func start_stats():
	ming = "Combat Dummy"
	stats.max_hp = 99999
	
var time = 0
var play = false
func _process(delta):
	if play:
		if time <= 0:
			if $Sprite.frame < $Sprite.hframes - 1:
				$Sprite.frame += 1
			else:
				$Sprite.frame = 0
				play = false
			time = 0.06
		else:
			time -= delta

func take_damage(val):
	.take_damage(val)
	play = true
	
func die():
	stats.max_hp = 99999