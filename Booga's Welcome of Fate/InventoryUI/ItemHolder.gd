extends TextureButton

class_name ItemHolder

var item : Item  = null setget set_item
var count = 0

func _ready():
	pass
	#set_item(item_database.make_item("turnip"))

func set_item(i : Item, amt = 1):
	item = i
	$ItemTexture.texture = load("res://sprites/items/" + item.ming + ".png")
	count = amt