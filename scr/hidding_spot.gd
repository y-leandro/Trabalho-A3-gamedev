extends Node3D

@export var player: Node3D = null

func _ready() -> void:
	$DirIndication.hide()
	assert(player != null, "algum hiding spot não recebeu o player como variavel")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		if global_position.distance_to(player.global_position) < 1.5:
			player.global_position = $DirIndication.global_position
			player.global_rotation = $DirIndication.global_rotation
