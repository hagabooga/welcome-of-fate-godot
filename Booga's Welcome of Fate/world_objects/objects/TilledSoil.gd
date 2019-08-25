extends WorldObject

var plant : Plant

func clicked(tewl : Tool):
	if tewl is Seedbag and ($Sprite.frame == 1 or $Sprite.frame == 2):
		$Seed.visible = true
	else:
		var count = 0
		for x in get_parent().get_children():
			if x.tile_pos == tile_pos:
				count += 1
		if count < 2 and ($Sprite.frame == 0 and tewl is Hoe) or ($Sprite.frame == 1 and tewl is WateringCan):
			$Sprite.frame += 1