extends Node2D

class_name ItemDrop

var count = 0
var ming: String

const IMPULSE_X = 0.4
const IMPULSE_Y_LOWER = -1.5
const IMPULSE_Y_UPPER = -1.0
const IMPULSE_MULTIPLIER = 200

func setup_item(ming):
	self.ming = ming
	$RigidBody2D/Area2D/Sprite.texture = load("res://sprites/items/" + ming + ".png")

func _ready():
	$Stopper/CollisionShape2D.disabled = false
	randomize()
	$RigidBody2D.friction = 0.02
	$RigidBody2D.bounce = 0.5
	$RigidBody2D.apply_central_impulse(\
		Vector2(rand_range(-IMPULSE_X, IMPULSE_X), rand_range(-IMPULSE_Y_LOWER, -IMPULSE_Y_UPPER)) \
		* IMPULSE_MULTIPLIER)
 
func _physics_process(delta):
	if not $RigidBody2D.sleeping:
		if $RigidBody2D.get_colliding_bodies() != []:
			count += 1
		if count > 4:
			$RigidBody2D.mode = RigidBody2D.MODE_STATIC
			$AnimationPlayer.play("idle")
	if $RigidBody2D.mode == RigidBody2D.MODE_STATIC:
		for x in $RigidBody2D/Area2D.get_overlapping_areas():
			sound_player.play_sound(16, self, false, true)
			x.get_parent().add_item(ming)
			get_tree().current_scene.floating_items.erase($RigidBody2D)
			get_tree().current_scene.floating_items.erase($Stopper)
			queue_free()

func add_ignore_other_items(array):
	for x in array:
		$RigidBody2D.add_collision_exception_with(x)
