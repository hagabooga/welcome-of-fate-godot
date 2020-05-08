extends Node2D

class_name ItemDrop

var count = 0
var ming: String

const BOUNCES = 4
const IMPULSE_X = 0.4
const IMPULSE_Y_LOWER = -1.5
const IMPULSE_Y_UPPER = -1.0
const IMPULSE_MULTIPLIER = 275
const FRICTION = 0.02
const BOUNCE = 0.5

func setup_item(mingz):
	self.ming = mingz
	$RigidBody2D/Area2D/Sprite.texture = load("res://sprites/items/" + mingz + ".png")

func _ready():
	$Stopper/CollisionShape2D.disabled = false
	randomize()
	var phys_mat = PhysicsMaterial.new()
	phys_mat.friction = FRICTION
	phys_mat.bounce = BOUNCE
	$RigidBody2D.physics_material_override = phys_mat
#	$RigidBody2D.friction = FRICTION
#	$RigidBody2D.bounce = BOUNCE
	$RigidBody2D.apply_central_impulse(\
		Vector2(rand_range(-IMPULSE_X, IMPULSE_X), rand_range(-IMPULSE_Y_LOWER, -IMPULSE_Y_UPPER)) \
		* IMPULSE_MULTIPLIER)
 
func _physics_process(delta):
	if $RigidBody2D.mode == RigidBody2D.MODE_STATIC:
		for x in $RigidBody2D/Area2D.get_overlapping_areas():
			sound_player.play_sound(16, self, false, true)
			x.get_parent().add_item(ming)
			get_tree().current_scene.floating_items.erase($RigidBody2D)
			get_tree().current_scene.floating_items.erase($Stopper)
			queue_free()
	else:
		if $RigidBody2D.get_colliding_bodies() != []:
			print($RigidBody2D.get_colliding_bodies())
			count += 1
		if count > BOUNCES:
			$RigidBody2D.mode = RigidBody2D.MODE_STATIC
			$AnimationPlayer.play("idle")

func add_ignore_other_items(array):
	for x in array:
		$RigidBody2D.add_collision_exception_with(x)
