extends Chest

export(PoolStringArray) var items
var opened := false

func _ready():
	for x in items:
		$Node2D/Control/InventoryList.add_item(item_database.make_item(x))
		
func right_clicked():
	.right_clicked()
	if !opened:
		sound_player.play_sound(64, self, false)
		opened = true