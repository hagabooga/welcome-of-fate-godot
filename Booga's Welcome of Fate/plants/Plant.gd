extends Actionable

var days_elapsed = 0
var tile_pos
var stages = {}
var ming

func _ready():
	world_globals.connect("next_day", self, "_on_next_day")
	z_index = world_globals.tilemap_soil.world_to_map(global_position).y
	action_string = "Pick Up"
	

func _on_next_day():
	days_elapsed += 1
	if days_elapsed in stages:
		var stage = stages[days_elapsed]
		var path = (ming.to_lower()) + "/" + stage
		$Sprite.texture = load("res://plants/" + path.to_lower() + ".png")
		$StaticBody2D/CollisionShape2D.disabled = false
		if (stage == "ready"):
			$CollisionShape2D.disabled = false

func _on_Timer_timeout():
	queue_free()

func apply_action(user):
	$Sprite.texture = load("res://sprites/items/" + ming.to_lower() + ".png")
	user.find_node("UI").find_node("Inventory").add(item_database.make_item(ming))
	$AnimationPlayer.play("Pluck")
	$Timer.start()
