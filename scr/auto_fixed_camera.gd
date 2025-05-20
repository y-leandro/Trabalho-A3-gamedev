extends Node3D

var area3d: Area3D
var camera: Camera3D
var player: Node3D

var was_player_in_last_frame = false

@export var ashely_look_at_me = false

func _ready() -> void:
	for c in get_children():
		if c is Area3D:
			area3d = c
		if c is Camera3D:
			camera = c
		
	assert(area3d != null, "ta faltando alguma area3d em um autofixedcamera")
	assert(camera != null, "ta faltando alguma camera em um autofixedcamera")

func _process(delta: float) -> void:
	for b in area3d.get_overlapping_bodies():
		if b.name == "player":
			if !was_player_in_last_frame:
				player = b
				was_player_in_last_frame = true
				camera.current = true
	
	var is_player_in = false
	for b in area3d.get_overlapping_bodies():
		if b.name == "player":
			if !was_player_in_last_frame:
				is_player_in = true
	
	if !is_player_in:
		was_player_in_last_frame = false
	
	if player != null and ashely_look_at_me:
		camera.look_at(player.global_position + Vector3(0, 0.5, 0))
