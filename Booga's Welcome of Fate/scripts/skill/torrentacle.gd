extends SingleSkillAttack


func activate_on_enemy(s : Skill, e : Enemy):
	.activate_on_enemy(s,e)
	if enemy != null:
		enemy.can_move = false
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	._on_AnimationPlayer_animation_finished(anim_name)
	if enemy != null:
		enemy.can_move = true