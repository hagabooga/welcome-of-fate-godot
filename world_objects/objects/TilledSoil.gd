extends WorldObject

class_name TilledSoil

var plant : Plant = null

func _ready():
	world_globals.connect("next_day", self, "grow")

func clicked(tewl : Item):
	if $AnimationPlayer.is_playing() || tewl == null:
		return
	if !$Seed.visible and plant == null and tewl.type == "seedbag" and ($Sprite.frame == 1 or $Sprite.frame == 2):
		$Seed.visible = true
		var pl = load("res://plants/turnip/Soil_Turnip.tscn").instance()
		$Plant.add_child(pl)
		plant = pl
		print("plant seeded: ", pl.ming)
		$Plant.modulate.a = 1
	else:
		print("WHAT")
		var count = 0
		for x in get_parent().get_children():
			if x.tile_pos == tile_pos:
				count += 1
		if count < 2 and ($Sprite.frame == 0 and tewl.type == "hoe") or ($Sprite.frame == 1 and tewl.type == "watering can"):
			$Sprite.frame += 1
			print("asdasdas")

func right_clicked():
	if ready_to_harvest():
		plant.frame += 1
		$AnimationPlayer.play("plant_pickup")

func grow():
	if $Sprite.frame == 2:
		$Sprite.frame = 1
		if plant != null:
			plant.grow_one_day()
			if plant.current_stage != -1:
				$Seed.visible = false
	if $Sprite.frame == 1 and plant == null:
		var i = randi()%100
		if i < 20:
			$Sprite.frame = 0

func ready_to_harvest() -> bool:
	return plant != null and !$Seed.visible and plant.current_stage == len(plant.stages) - 1

func plant_pickup():
	$Plant.get_child(0).queue_free()
	plant = null