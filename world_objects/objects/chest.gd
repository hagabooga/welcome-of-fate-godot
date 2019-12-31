tool

extends WorldObject

class_name Chest




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

func right_clicked():
	$Node2D.visible = true

func _ready():
	$Node2D/Control/InventoryList.resize_to_holder_amount(Control.PRESET_CENTER)
	ming = "chest"

	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Node2D.visible = false


func _on_Button_pressed():
	$Node2D.visible = false

func _on_CloseInvArea_body_exited(body):
	if body.name == "Player":
		_on_Button_pressed()

func save_data() -> Array:
	var items = []
	var holders = $Node2D/Control/InventoryList.get_holders()
	for i in range(len(holders)):
		var holder = holders[i]
		items.append([holder.item, holder.count] if holder.item != null else null)
	return items

func load_data(data : Array) -> void:
	var holders = $Node2D/Control/InventoryList.get_holders()
	for i in range(len(data)):
		var holder_data = data[i]
		if holder_data != null:
			var holder = holders[i]
			holder.item = data[i][0]
			holder.count = data[i][1]
