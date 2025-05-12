extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

@onready var model = $model
@onready var anim = $anim

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		var target_angle = atan2(-direction.x, -direction.z)
		model.rotation.y = lerp_angle(model.rotation.y, target_angle, delta * 8)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if direction:
		anim.play("walk")
	else:
		anim.play("idle")

	move_and_slide()
