extends WorldObject

class_name TilledSoil

var plant : Plant = null



func _ready():
	world_globals.connect("next_day", self, "grow")

func clicked(tewl : Item, user : Entity):
	if plant != null:
		if tewl.type == "sickle":
			if plant.has_grown():
				$Plant.get_child(0).queue_free()
				plant = null
				user.use_energy(tewl.energy_cost)
				return
		elif tewl.type == "hoe":
			if !plant.has_grown():
				plant_pickup()
				$Seed.visible = false
				user.use_energy(tewl.energy_cost)
				return
	if $AnimationPlayer.is_playing() || tewl == null:
		return
	if tewl.type == "seedbag" and !$Seed.visible and plant == null and ($Sprite.frame == 1 or $Sprite.frame == 2):
		$Seed.visible = true
		var pl = plant_database.make_plant(tewl.ming.split(" ")[0])
		$Plant.add_child(pl)
		plant = pl
		print("plant seeded: ", pl.ming)
		$Plant.modulate.a = 1
		user.use_energy(tewl.energy_cost)
		return ClickAction.new(CONSUME, null)
	else:
		var count = get_parent().get_parent().used_cells.count(tile_pos)
		if (count < 1) and (($Sprite.frame == 0 and tewl.type == "hoe") or ($Sprite.frame == 1 and tewl.type == "watering can")):
			if tewl.type == "watering can":
				if !tewl.can_pour():
					return
				tewl.current_amount -= 1
			$Sprite.frame += 1
			user.use_energy(tewl.energy_cost)

func right_clicked():
	if ready_to_harvest():
		if plant.multi:
			plant.go_second_last_stage()
		else:
			plant.frame += 1
		var sprite = Sprite.new()
		sprite.texture = load("res://sprites/items/%s.png"%plant.ming)
		sprite.centered = false
		$PlantPickup.add_child(sprite)
		$AnimationPlayer.play("plant_pickup")
		return ClickAction.new(ADD_ITEM, [plant.ming])

func grow():
	if $Sprite.frame == 2:
		$Sprite.frame = 1
		if plant != null:
			plant.grow_one_day()
			if plant.current_stage != -1:
				$Seed.visible = false
	else:
		if plant != null:
			plant.no_water()
	if $Sprite.frame == 1 and plant == null:
		var i = randi()%100
		if i < 20:
			$Sprite.frame = 0

func ready_to_harvest() -> bool:
	return plant != null and !$Seed.visible and plant.current_stage == len(plant.stages) - 1 and !plant.dead

func hide_plant():
	if !plant.multi:
		$Plant.visible = false

func plant_pickup():
	if !plant.multi:
		$Plant.get_child(0).queue_free()
		plant = null
		$Plant.visible = true
	$PlantPickup.get_child(0).queue_free()
		