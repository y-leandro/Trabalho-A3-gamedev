extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

var lp = 5


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
	var direction := Vector3.ZERO
	var cam = get_viewport().get_camera_3d()
	if input_dir != Vector2.ZERO:
		var cam_yaw = cam.global_transform.basis.get_euler().y
		direction = (Vector3(input_dir.x, 0, input_dir.y)).rotated(Vector3.UP, cam_yaw).normalized()
		
		var target_angle = atan2(direction.x, direction.z)
		model.rotation.y = lerp_angle(model.rotation.y, target_angle, delta * 8)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		
	if direction:
		anim.play("walk")
	else:
		anim.play("idle")
		
		
	if lp < 0:
		##velocity.y = JUMP_VELOCITY
		pass
	move_and_slide()

func hitfunc(hit):
	lp -= hit
