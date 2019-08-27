extends WorldObject

var plant : Plant = null

func _ready():
	world_globals.connect("next_day", self, "grow")

func clicked(tewl : Tool):
	if $AnimationPlayer.is_playing():
		return
	if !$Seed.visible and plant == null and tewl is Seedbag and ($Sprite.frame == 1 or $Sprite.frame == 2):
		$Seed.visible = true
		var pl = tewl.plant.instance()
		$Plant.add_child(pl)
		plant = pl
		print("plant seeded: ", pl.ming)
	elif plant != null and !$Seed.visible and plant.current_stage == len(plant.stages) - 1:
		plant.frame += 1
		$AnimationPlayer.play("plant_pickup")
	else:
		var count = 0
		for x in get_parent().get_children():
			if x.tile_pos == tile_pos:
				count += 1
		if count < 2 and ($Sprite.frame == 0 and tewl is Hoe) or ($Sprite.frame == 1 and tewl is WateringCan):
			$Sprite.frame += 1

func grow():
	if $Sprite.frame == 2:
		$Sprite.frame = 1
		if plant != null:
			plant.grow_one_day()
			if plant.current_stage != -1:
				$Seed.visible = false

func plant_pickup():
	$Plant.get_child(0).queue_free()
	plant = null