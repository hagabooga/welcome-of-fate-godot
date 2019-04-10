extends StaticBody2D#"res://item.gd"

var days_elapsed = 0
var tile_pos
var stages = {}
var ming


func _on_next_day():
	days_elapsed += 1
	if days_elapsed in stages:
		var stage = stages[days_elapsed]
		var path = (ming.to_lower()) + "/" + stage
		$Sprite.texture = load("res://plants/" + path + ".png")
		$CollisionShape2D.disabled = false
		if (stage == "ready"):
			$Actionable/GrabArea.disabled = false


func _ready():
	world_globals.connect("next_day", self, "_on_next_day")


func _on_Timer_timeout():
	var i = 0
	for x in world_globals.plants:
		if x.tile_pos == self.tile_pos:
			world_globals.plants.remove(i)
			break
		i += 1
	queue_free()
	#print(inventory.items)


func _on_Actionable_action(user):
	$Sprite.texture = load("res://sprites/items/" + ming.to_lower() + ".png")
	user.find_node("ItemList").add(inventory.find_item(ming))
	$CollisionShape2D.disabled = true
	$Actionable/GrabArea.disabled = true
	$AnimationPlayer.play("Pluck")
	$Timer.start()
