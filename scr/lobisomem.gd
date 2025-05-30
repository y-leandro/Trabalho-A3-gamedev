extends CharacterBody3D

@export var player : Node3D = null
@onready var anim = $AnimationPlayer
@onready var model = self

const WALKING_SPEED = 50.0
const RUNNING_SPEED = 225.0
const JUMP_VELOCITY = 4.5

const hit = 2

enum States {
	idle,
	chase
}
enum IdleStates {
	still,
	walking,
	turning,
}
enum ChaseState {
	running,
	stunned,
}

var rng = RandomNumberGenerator.new()
var dir = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()

var timer = 1;
var state = States.idle
var idle_state = IdleStates.walking
var chase_state = ChaseState.running

var last_saw_player_pos = Vector3()

func _ready() -> void:
	assert(player != null, "lobo pidão pede pelo node do player")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		if state == States.chase:
			state = States.idle
		elif state == States.idle:
			state = States.chase
	## Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# TODO: ARRUMAR
	#$RayCast3D.target_position = player.global_position - global_position + Vector3(0, 0.5,0 )
	#if $RayCast3D.get_collider() != null:
		#if $RayCast3D.get_collider().name == "player":
			#last_saw_player_pos = $RayCast3D.get_collider().global_position
	
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if (state == States.idle):
		if (idle_state == IdleStates.walking):
			velocity.x = dir.x * WALKING_SPEED * delta
			velocity.z = dir.y * WALKING_SPEED * delta
			timer -= delta
			var target_angle = atan2(-dir.x, -dir.y)
			model.rotation.y = lerp_angle(model.rotation.y, target_angle, delta * 8)
			
			#anim.play("walk")
			if timer <= 0:
				idle_state = IdleStates.still
				timer = randf_range(2, 4)
		if idle_state == IdleStates.still:
			#anim.play("idle")
			velocity = Vector3()
			timer -= delta
			if timer <= 0:
				idle_state = IdleStates.walking
				timer = randf_range(2, 4)
				dir = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()
	if state == States.chase:
		if chase_state == ChaseState.running:
			var l_pos = Vector2(global_position.x, global_position.z)
			var p_pos = Vector2(last_saw_player_pos.x, last_saw_player_pos.z)
			if l_pos.distance_to(p_pos) < 1.5:
				# todo: ataque lobisomi
				player.hitfunc(hit)
				pass
			
			var run_dir = l_pos.direction_to(p_pos).normalized()
			
			velocity.x = run_dir.x * RUNNING_SPEED * delta
			velocity.z = run_dir.y * RUNNING_SPEED * delta
			
			# todo: detectar stun pela lanterna
			if Input.is_action_just_pressed("e"):
				timer = randf_range(3, 4)
				chase_state = ChaseState.stunned
		if chase_state == ChaseState.stunned:
			velocity = Vector3()
			timer -= delta
			if timer <= 0:
				# todo: checar se o player ainda esta no campo de visão
				chase_state = ChaseState.running
				print("peness")

	move_and_slide()
