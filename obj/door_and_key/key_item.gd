extends Area3D

@export var k_name := ""

func _ready() -> void:
	assert(k_name != "", "informar nome pra chave")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		for b in get_overlapping_bodies():
			if b.name == "player":
				b.chaves.append(k_name)
				queue_free()
