extends WorldObject

class_name TilledSoil

var plant : Plant = null


func _ready():
	world_globals.connect("next_day", self, "grow")

func clicked(tewl : Item, user : Attributes):
	var energy_cost = 4
	if plant != null:
		if tewl.type == "sickle":
			if plant.has_grown():
				plant = null
				$Plant.get_child(0).queue_free()
				return [ClickAction.new(ClickAction.NONE)]
		elif tewl.type == "hoe":
			if $Seed.visible:
				$Seed.visible = false
				plant = null
				return [ClickAction.new(ClickAction.NONE)]
	if $AnimationPlayer.is_playing() || tewl == null:
		return
	if tewl.type == "seedbag" and !$Seed.visible and plant == null and ($Sprite.frame == 1 or $Sprite.frame == 2):
		$Seed.visible = true
		var pl = plant_database.make_plant(tewl.ming.split(" ")[0])
		$Plant.add_child(pl)
		plant = pl
		print("plant seeded: ", pl.ming)
		$Plant.modulate.a = 1
		return [ClickAction.new(ClickAction.CONSUME)]
	else:
		#var count = get_parent().get_parent().used_cells.count(tile_pos)
		#if (count < 1) and
		#print(get_parent().get_parent().used_cells)
		var something_ontop = !tile_pos in get_parent().get_parent().used_cells
		if  something_ontop and (($Sprite.frame == 0 and tewl.type == "hoe") or ($Sprite.frame == 1 and tewl.type == "watering can")):
			if tewl.type == "watering can":
				if !tewl.can_pour():
					return
				sound_player.play_sound(60,self)
				tewl.current_amount -= 1
				$Sprite.frame += 1
			else:
				sound_player.play_sound(62,self)
				$Sprite.frame += 1
			return [ClickAction.new(ClickAction.NONE)]
	return null

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
		sound_player.play_sound(16,self)
		return [ClickAction.new(ClickAction.ADD_ITEM, [plant.ming]), ClickAction.new(ClickAction.PLAY_ANIM, ["slash", 2])]

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
		return
	if $PlantPickup.get_child_count() != 0:
		$PlantPickup.get_child(0).queue_free()


func save_data() -> Array:
	if $Plant.get_child_count() > 0:
		var a = Utility.deep_copy_node($Plant.get_child(0))
	return [
		Utility.deep_copy_node($Plant.get_child(0)) if $Plant.get_child_count() > 0 else null,
		$Seed.visible,
		$Sprite.frame
	]
	
func load_data(data : Array) -> void:
	if data[0] != null:
		plant = data[0]
		$Plant.add_child(data[0])
		#print(data[0].days_past)
	$Seed.visible = data[1]
	$Sprite.frame = data[2]