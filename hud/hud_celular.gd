extends Node2D
@export var app_selecionado = 0
@onready var apps = [
	{
		name = "zap", 
		icone = $MenuPrincipal/messenger,
		interface =$Zap
	},
	{
		name = "gps",
		icone = $MenuPrincipal/gps,
		interface = $GPS
	},
	{
		name = "sinal",
		icone = $MenuPrincipal/sinal,
		interface = $Sinal
		
	},
	{
		name = "sair",
		icone = $MenuPrincipal/sair,
		interface = $Sair
	}
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active:
		if Input.is_action_just_pressed("left"):
			app_selecionado = (app_selecionado - 1) % 4
		elif Input.is_action_just_pressed("right"):
			app_selecionado = (app_selecionado + 1) % 4
		$MenuPrincipal/seletor.global_position = apps[app_selecionado].icone.global_position
		if Input.is_action_just_pressed("e"):
			$MenuPrincipal.hide()
			apps[app_selecionado].interface.show()
			is_active = false
			apps[app_selecionado].interface.setup()
			apps[app_selecionado].interface.set_process(true)

var is_active = true
