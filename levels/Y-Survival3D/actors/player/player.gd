extends CharacterBody3D


@export var normal_speed := 3.0
@export var sprint_speed := 6.0
@export var jump_velocity := 4.0
@export var gravity := 0.2
@export var mouse_sensitivity := 0.004

# CTRL + DRAG node
@onready var head: Node3D = $Head
@onready var interaction_ray_cast: RayCast3D = $Head/InteractionRayCast


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()

func _physics_process(delta: float) -> void:
	move()
	
func move() -> void:
	
	#var is_sprinting : bool = false
	#if is_on_floor():
		#is_sprinting = Input.is_action_just_pressed("sprint")
		#
	#else:
		#velocity.y -= gravity
		#is_sprinting = false
		
	#var speed := normal_speed if not is_sprinting else sprint_speed
	if is_on_floor():
		velocity.y = jump_velocity if Input.is_action_just_pressed("jump") else 0
	else:
		velocity.y -= gravity
	#var speed := normal_speed if not is
	#var speed: float = sprint_speed if Input.is_action_just_pressed("sprint") else normal_speed
	
	var input_dir := Input.get_vector("move_left","move_right","move_forward","move_backward")
	var direction := transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	
	#velocity.z = direction.z * speed
	#velocity.x = direction.x * speed
	velocity.z = direction.z * (sprint_speed if Input.is_action_pressed("sprint") else normal_speed)
	velocity.x = direction.x * (sprint_speed if Input.is_action_pressed("sprint") else normal_speed)
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)

func look_around(relative : Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	#head.rotate_x(-relative.y * mouse_sensitivity)
	#head.rotation_degrees.x = clamp(head.rotation_degrees.x, -90, 90)
	#smoother variant is below
	head.rotate_x(-relative.y * mouse_sensitivity)
	head.rotation.x = clampf(head.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#const SPEED = 3.0
#const JUMP_VELOCITY = 4.5
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
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
#
	#move_and_slide()
