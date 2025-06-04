extends StaticBody3D

@export var k_name := ""

func _ready() -> void:
	assert(k_name != "", "informar nome pra chave")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		for b in $Area3D.get_overlapping_bodies():
			if b.name == "player":
				if b.chaves.has(k_name):
					b.chaves.append(k_name)
					open()

func open():
	# todo: melhorar saporra
	queue_free()
