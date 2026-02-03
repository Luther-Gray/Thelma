extends CharacterBody3D

#//Resources
@export var ResourceCore : Core
@export var Attributes : Attribute
@export var Class : Classes

#//Imported
@onready var Head: Node3D = $Head
@onready var StardustAnim: AnimationPlayer = $Stardust/AnimationPlayer
@onready var Camera: Camera3D = $Head/PlayerCamera
@onready var Collision: CollisionShape3D = $PlayerCollision
@onready var CameraRay: RayCast3D = $Head/PlayerCamera/CameraRay

@onready var SneakRay: RayCast3D = $CrouchRayCast
@onready var MOVState: MovementStateMachine = $MovementStateMachine
@onready var ACTState: ActionStateMachine = $ActionStateMachine
@onready var ATKState: Node3D = $AttackStateMachine

#//Variables
#Alacrity Calcs
@onready var WalkSpeed : float = 4.0 + (Attributes.Alacrity / 8.0)
@onready var JumpHeight : float = 4.0 + (Attributes.Alacrity / 32.0)
@onready var SprintSpeed : float = 6.0 + (Attributes.Alacrity/ 6.0)
@onready var SneakSpeed: float = 3.0 + (Attributes.Alacrity/ 16.0)

# Movement
var InputDir := Vector2.ZERO
var CurrentSpeed: float
var Direction := Vector3.ZERO
const ACCEL = 1.25
const DECEL = 0.8
var canFootstep : bool = true
var GroundedFootStep : bool

# HeadBob
var HeadBobFreq : float = 2.0
var HeadBobAmp : float = 0.02
var HeadBobTimer : float = 0.0
# Mouse
var isMouseCaptured : bool = true
@export_range(0, 1) var MOUSE_SENSITIVITY : float = 0.35

func _ready() -> void:
	Singletons.PLAYER = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	print(Attributes.Alacrity)

#// Input Events---------------------------------------
func _input(event: InputEvent) -> void:

#// Mouse Escape/ Mouse Lock
	if event.is_action_pressed("Escape"):
		isMouseCaptured = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event.is_action_pressed("Click"):
		if !isMouseCaptured:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			isMouseCaptured = true

#// Mouse Look
	if event is InputEventMouseMotion and isMouseCaptured:
	# Left & Right Mouse Look
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
	# Up & Down Mouse Look
		Head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))
	#Clamp how far up and down the player can look.
		Head.rotation.x = clamp(Head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta: float) -> void:
#// DEBUG
	Singletons.Debug._add_debug("Current Velocity", str(velocity), 1)
	Singletons.Debug._add_debug("Movement State", str(MOVState.CurrentState.name), 2)
	Singletons.Debug._add_debug("Action State", str(ACTState.CurrentState.name), 3)

# Add the Gravity-----------------------
	if ! is_on_floor():
		velocity += get_gravity() * delta
# HeadBob Timer
	HeadBobTimer += delta * velocity.length() * float(is_on_floor())
	Camera.transform.origin = _headbob(HeadBobTimer)

# Handle Walking --------------------------------
	InputDir = Input.get_vector("Left", "Right", "Forwards", "Backwards")
	Direction = lerp(Direction , (transform.basis * Vector3(InputDir.x, 0, InputDir.y)).normalized(), delta * 8)
	# Anim Handling
	if InputDir == Vector2(0,0):
		StardustAnim.current_animation = "LOC_Idle"
		StardustAnim.speed_scale = 0.2
	if InputDir== Vector2(0,-1):
		StardustAnim.current_animation = "LOC_Walk_F"
		StardustAnim.speed_scale = 0.8
		print("Forwards")

	# Move
	if Direction:
		velocity.x = lerp(velocity.x, Direction.x * CurrentSpeed, ACCEL)
		velocity.z = lerp(velocity.z, Direction.z * CurrentSpeed, ACCEL)
	else:
		velocity.x = move_toward(velocity.x, 0, DECEL)
		velocity.z = move_toward(velocity.z, 0, DECEL)
	if abs(velocity.x) < 0.1:
		velocity.x = 0
	if abs(velocity.z) < 0.1:
		velocity.z = 0

	# Camera Sway
	if InputDir.x > 0 :
		Head.rotation.z = lerp_angle(Head.rotation.z, deg_to_rad(-2), 0.05)
	elif InputDir.x < 0 :
		Head.rotation.z = lerp_angle(Head.rotation.z, deg_to_rad(2), 0.05)
	else:
		Head.rotation.z = lerp_angle(Head.rotation.z, deg_to_rad(0), 0.05)
	_push_rigid_body(delta)
	move_and_slide()

# Headbob
func _headbob(HeadBobTimer) -> Vector3:
	var HeadBobPosition = Vector3.ZERO
	HeadBobPosition.y = sin(HeadBobTimer * HeadBobFreq) * HeadBobAmp
	return HeadBobPosition
# Object Collide Physics | I stole this from Reddit, don't ask me why it works.
func _push_rigid_body(delta:float):
	var col := get_last_slide_collision()
	if col:
		var ColCollider := col.get_collider()
		var ColPosition := col.get_position()
		if not ColCollider is RigidBody3D:
			return
		var PushDirection := -col.get_normal()
		var PushPosition = ColPosition - ColCollider.global_position
		ColCollider.apply_impulse(PushDirection * 500 * delta, PushPosition)
