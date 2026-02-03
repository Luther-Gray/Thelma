extends State
class_name SneakState

# Crouching
var StandingHeight :float = 1.8
var SneakHeight : float = 0.9
var CollisionHeight : float = 2.0
var SneakCollisionHeight : float = 0.9
var isSneaking : bool = false

# Enter State
func _enter_state():
	Singletons.PLAYER.Head.position.y = SneakHeight
	Singletons.PLAYER.Collision.shape.height = SneakCollisionHeight
	Singletons.PLAYER.Collision.position.y = 0.4
	Singletons.PLAYER.CurrentSpeed = Singletons.PLAYER.SneakSpeed
	isSneaking = true

# Input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Sneak") and Singletons.PLAYER.is_on_floor() and isSneaking and !Singletons.PLAYER.SneakRay.is_colliding():
		StateChanged.emit("IdleState")
		get_viewport().set_input_as_handled()

# Exit State
func _exit_state():
	isSneaking = false
	Singletons.PLAYER.Head.position.y = StandingHeight
	Singletons.PLAYER.Collision.shape.height = CollisionHeight
	Singletons.PLAYER.Collision.position.y = 1.0
	Singletons.PLAYER.CurrentSpeed = Singletons.PLAYER.WalkSpeed
