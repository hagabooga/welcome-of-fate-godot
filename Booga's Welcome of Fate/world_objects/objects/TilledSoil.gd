extends WorldObject

func clicked(tewl):
	var count = 0
	for x in get_parent().get_children():
		if x.tile_pos == tile_pos:
			count += 1
	if count < 2 and ($Sprite.frame == 0 and tewl is Shovel) or ($Sprite.frame == 1 and tewl is WateringCan):
		$Sprite.frame += 1