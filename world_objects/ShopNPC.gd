extends NPC

class_name ShopNPC

export var item_list = []

func _ready():
	set_item_list()
	for x in item_list:
		$Node2D/Control/ShopList.add_item(item_database.make_item(x))
		#print("yo")
		
func set_item_list():
	pass
	
func right_clicked():
	$Node2D.visible = true

func _on_Button_pressed():
	$Node2D.visible = false

func _on_ShopRange_body_exited(body):
	if body is Player:
 		_on_Button_pressed()
		
