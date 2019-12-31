tool

extends Chest

func clicked(tewl: Item, user : Attributes):
	return [ClickAction.new(ClickAction.NONE)]

func _ready():
	ming = "sell bin"
	world_globals.connect("next_day", self, "sell_items")

func sell_items():
	for x in $Node2D/Control/InventoryList.find_node("GridContainer").get_children():
		if x.item != null:
			get_tree().get_current_scene().player.add_cash(x.item.cost * x.count)
			x.clear_holder()