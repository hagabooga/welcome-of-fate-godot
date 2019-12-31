tool

extends Chest

func clicked(tewl: Item, user : Attributes):
	if tewl != null and tewl.type == "axe":
		var items_to_add = ["chest"]
		for x in $Node2D/Control/InventoryList/GridContainer.get_children():
			if x.item != null:
				for y in range(x.count):
					items_to_add.append(x.item.ming)
		destroy_and_remove_from_map()
		sound_player.play_sound(58,self, false)
		return [ClickAction.new(ClickAction.ADD_ITEM, items_to_add)]


func _ready():
	ming = "sell bin"

	