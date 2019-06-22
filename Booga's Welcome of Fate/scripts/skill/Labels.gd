extends VBoxContainer


func set_labels(s):
	$Ming.text = s.ming.capitalize()
	$Rank.text = "Rank: (%d / %d)"%[s.rank, s.max_rank]
	$Desc.text = s.desc
	$Detail.text = ""
	if s.rank == 0:
		$Detail.text = "\nSkill not yet learned!"
	else:
		$Detail.text += "\nDamage: %d"%s.damage
		$Detail.text += "\nMana Cost: %d"%s.mana
		$Detail.text += "\nCooldown: %fs"%s.cooldown