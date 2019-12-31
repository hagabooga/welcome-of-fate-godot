extends Map


var ming : String = ""

enum {none, warrior, mage, rogue}
var selected_job = none

func _ready():
	pass


	
func start_game():
	
	$Player.visible = true
	$Player/UI/UIController.open_close_stats(false, false)
	$Player/UI/UIController.open_close_skill(false, false)
	$Player/UI/UIController.open_close_inventory(false, false)
	match selected_job:
		warrior: $Player.set_script(load("res://scripts/player/stats/warrior.gd"))
		mage: $Player.set_script(load("res://scripts/player/stats/mage.gd"))
		rogue: $Player.set_script(load("res://scripts/player/stats/rogue.gd"))
	$Player.ming = ming
	$Player.update_stats()
	$Warp.load_stuff()
	
# CHOOSE JOB

func _on_Warrior_pressed():
	$CanvasLayer/ChooseJob/JobDescription/SelectedClass.bbcode_text =\
	 "[center][color=black]Selected Class: [/color][color=red]Warrior[/color][/center]"
	$CanvasLayer/ChooseJob/JobDescription/ProsCons.text = \
	"Strong and sturdy.\n+ High Health\n+High Physical Damage and Armor\n"+\
	"- Low Hit Chance\n- Weak to Magical Damage"
	selected_job = warrior
	sound_player.play_sound(43,$Player)


func _on_Mage_pressed():
	$CanvasLayer/ChooseJob/JobDescription/SelectedClass.bbcode_text =\
	 "[center][color=black]Selected Class: [/color][color=#16d3f0]Mage[/color][/center]"
	$CanvasLayer/ChooseJob/JobDescription/ProsCons.text = \
	"Excels with magic.\n+ High Mana\n+ High Magical Damage\n- Low Health and Armor\n- Low Physical Damage\n"
	selected_job = mage
	sound_player.play_sound(43,$Player)


func _on_Rogue_pressed():
	$CanvasLayer/ChooseJob/JobDescription/SelectedClass.bbcode_text =\
	 "[center][color=black]Selected Class: [/color][color=green]Rogue[/color][/center]"
	$CanvasLayer/ChooseJob/JobDescription/ProsCons.text = \
	"Fast and sharp.\n+ High Hit, Dodge, and Critical Chance\n"+\
	"+ Quick movement and actions\n- Low Health and Defense\n- Low Base Damage\n"
	selected_job = rogue
	sound_player.play_sound(43,$Player)


func _on_Select_pressed():
	if selected_job != none:
		sound_player.play_sound(43,$Player)
		start_game()
	else:
		$CanvasLayer/ChooseJob/Error.visible = true
		$CanvasLayer/ChooseJob/Error/Timer.start()
		sound_player.play_sound(33,self)
		
func _on_select_Timer_timeout():
	$CanvasLayer/ChooseJob/Error.visible = false


# MAIN MENU

func _on_LineEdit_text_entered(new_text):
	if len(new_text) > 0:
		sound_player.play_sound(43,$Player)
		ming = new_text
		$CanvasLayer/MainMenu.visible = false
	else:
		$CanvasLayer/MainMenu/Error.visible = true
		$CanvasLayer/MainMenu/Error/Timer.start()
		sound_player.play_sound(33,self)
	
	

	
func _on_Play_pressed():
	_on_LineEdit_text_entered($CanvasLayer/MainMenu/NameInput/LineEdit.text)

func _on_Load_pressed():
	sound_player.play_sound(43,self)

func _on_Quit_pressed():
	get_tree().quit()

func _on_Timer_timeout():
	$CanvasLayer/MainMenu/Error.visible = false



