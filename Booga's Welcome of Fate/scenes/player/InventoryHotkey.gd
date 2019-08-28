extends Panel

var selected_index = 0

func _ready():
	for x in range(10):
		$HotkeyList.add_icon_item(load("res://sprites/items/hoe.png"))
	$HotkeyList.select(0)
	
func _process(delta):
	if Input.is_action_just_released("scroll_up") and selected_index < $HotkeyList.get_item_count():
		selected_index += 1
		$HotkeyList.select(selected_index)
	if Input.is_action_just_released("scroll_down") and selected_index > 0:
		selected_index -= 1
		$HotkeyList.select(selected_index)

func _on_ItemList_item_activated(index):
	selected_index = index
