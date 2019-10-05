extends Panel

var skill : Skill
var cooldown_left = 0
var skill_page = null
	

func _process(delta):
	if (cooldown_left >= 0):
		cooldown_left -= delta

func can_activate():
	return cooldown_left < 0

func go_on_cooldown():
	cooldown_left = skill.cooldown


func _ready():
	skill_page = get_parent().get_parent().get_parent().get_parent().get_parent()
	skill = skill_database.make_skill(name.to_lower())
	$TextureButton.texture_normal = load("res://sprites/skills/%s.png"%name.to_lower())
	update_rank_label()
	
func update_rank_label():
	$Rank.text = "%d / %d"%[skill.rank,skill.max_rank]

func _on_TextureButton_pressed():
	rank_up()
	get_parent().get_parent().mouse_enter_skill_node(self)

func rank_up():
	if skill_page.sp <= 0:
		return
	skill_page.sp -= 1
	if skill.rank == 0:
		skill_page.emit_signal("on_skill_learned", skill)
	if skill.rank != skill.max_rank:
		skill.rank += 1
		update_rank_label()
		skill_page.emit_signal("on_skill_changed")
		