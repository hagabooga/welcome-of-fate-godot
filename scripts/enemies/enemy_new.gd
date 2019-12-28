extends Entity
class_name Enemy

var item_spit_out_scene = load("res://ItemSpitOut.tscn")

var item_drops = {}

func _ready():
	self.atk_spd = 1

	starting_stats()
	final_stats()
	
func _enter_tree():
	modulate.a = 0
	$AnimationPlayer.play("spawn")
	

func die() -> void:
	$AnimationPlayer.play("die")
	
func take_damage(dmg : Damage) -> void:
	if $AnimationPlayer.current_animation != "die":
		.take_damage(dmg)
		if hp <= 0:
			die()
			dmg.dealer.add_xp(5)
	
func deal_damage_to_target() -> void:
	if $EnemyMovement.target == null:
		print("target does not exist!!! cannot deal damage")
	if $EnemyMovement.target != null and weakref($EnemyMovement.target).get_ref():
		$EnemyMovement.target.take_damage(Damage.new(self, self.physical))


func starting_stats() -> void:
	pass

func final_stats():
	hp = self.max_hp
	mp = self.max_mp

func _on_AttackRange_body_entered(body):
	if $EnemyMovement.target == body:
		$EnemyMovement.attack_in_range = true


func _on_AttackRange_body_exited(body):
	if $EnemyMovement.target == body:
		$EnemyMovement.attack_in_range = false
		


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("idle")


func _on_Enemy_input_event(viewport, event, shape_idx):
	#print(event)
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print(name, " clicked with mouse!")
			
func spit_out_item():
	for x in item_drops.keys():
		var i = randi()%100
		if i < item_drops[x]:
			var spit = item_spit_out_scene.instance()
			get_parent().add_child(spit)
			spit.set_item(x)
			spit.play_spit_out(global_position)
