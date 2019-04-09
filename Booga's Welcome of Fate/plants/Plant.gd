extends StaticBody2D

var days_elapsed = 0
var plant_name
var tile_pos
var stages = {}
var item_id

func _on_next_day():
	days_elapsed += 1
	if days_elapsed in stages:
		var stage = stages[days_elapsed]
		var path = (plant_name.to_lower()) + "/" + stage
		$Sprite.texture = load("res://plants/" + path + ".png")
		$CollisionShape2D.disabled = false
		if (stage == "ready"):
			$Actionable/GrabArea.disabled = false


func _ready():
	world_globals.connect("next_day", self, "_on_next_day")

func _on_Grabbable_grabbing():
	$Sprite.texture = load("res://plants/" + plant_name.to_lower() + "/"+ "product"+ ".png")
	$CollisionShape2D.disabled = true
	$Actionable/GrabArea.disabled = true
	inventory.add_item(plant_name)
	$Timer.start()
	
#func _physics_process(delta):
#	if (y <= dy):
#		move_and_slide(Vector2(x,y))
#		y += (dy/time) * 2
#		time -= 1

func _on_Timer_timeout():
	queue_free()
