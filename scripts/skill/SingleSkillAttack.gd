extends Sprite

class_name SingleSkillAttack

var enemy = null
export(float) var duration 

func _ready():
	$AnimationPlayer.play("start")
	$AnimationPlayer.playback_speed = $AnimationPlayer.current_animation_length / duration

func _process(delta):
	if enemy != null:
		update_pos()

func enemy_death_functions():
	enemy = null

func activate_on_enemy(s : Skill, e : Enemy):
	enemy = e
	update_pos()
	e.connect("on_death", self, "enemy_death_functions")
	e.take_damage(s.damage)

func update_pos():
	z_index = enemy.z_index + 1
	global_position = enemy.global_position

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
