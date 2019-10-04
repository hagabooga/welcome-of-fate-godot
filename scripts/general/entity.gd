extends Attributes

class_name Entity

var damage_popup = load("res://scenes/general/DamagePopup.tscn")


var ming = "Entity No Name"
export(int) var move_speed
var can_move : bool = true
var velocity = Vector2.ZERO

func _ready():
	connect("on_hp_add", self, "make_damage_popup")
	connect("on_mp_add", self, "make_damage_popup")
	connect("on_energy_add", self, "make_damage_popup")
	
	
func make_damage_popup(text, color_pos, color_neg):
	var pop = ui_maker.make_damage_popup()
	get_tree().get_root().add_child(pop)
	pop.global_position = $PosAboveHead.global_position
	pop.set_text_and_play(text, color_pos, color_neg)

func _process(delta):
	pass
	#change_z_index_relative_to_tilemap()

func change_z_index_relative_to_tilemap() -> void:
	var z = owner.tilemap_soil.world_to_map(global_position).y
	if z >= 0:
		z_index = owner.tilemap_soil.world_to_map(global_position).y


func is_actionable() -> bool:
	return $Hitstun.in_hitstun() || !$Sprite/AnimationPlayer.is_playing()

func is_dead() -> bool:
	return hp > 0
	
func take_damage(dmg : Damage) -> void:
	#print(dmg.dealer.name,dmg.damage)
	add_hp(-dmg.damage)
	#print("yo")
	#var dmgpop = damage_popup.instance()
	#dmgpop.set_text_and_play(dmg.damage)
	#add_child(dmgpop)

func update_stats() -> void:
	pass

func use_energy(cost) -> bool:
	if cost > self.energy:
		return false
	self.energy -= cost
	return true

func _on_RegenTimer_timeout():
	if self.energy < self.max_energy: 
		self.energy += 1
		if self.energy > self.max_energy:
			self.energy = self.max_energy