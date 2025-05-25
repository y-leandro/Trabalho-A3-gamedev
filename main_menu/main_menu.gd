extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 

	print("u")
	#$menu1/MarginContainer/HBoxContainer/VBoxContainer/ContinueButton.connect("button_down", continuar_game)
	#$menu1/MarginContainer/HBoxContainer/VBoxContainer/NewgameButton.connect("button_down", new_jogo)
	#$menu1/MarginContainer/HBoxContainer/VBoxContainer/OptionsButton.connect("button_down", opcoes)
	#$menu1/MarginContainer/HBoxContainer/VBoxContainer/QuitButton.connect("button_down", quit) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func continuar_game():
	print("comococo")
	#add save para dai funincar

func new_jogo():
	get_tree().change_scene_to_file("")
	# add cena real
	
func opcoes ():
	print ("vanessaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")

func quit():
	get_tree().quit()
	
