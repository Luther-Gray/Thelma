extends State
class_name WalkState

# -> Idle
func _process_state(_delta: float):
#// -> Idle
	if Singletons.PLAYER.InputDir == Vector2.ZERO and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("IdleState")

func _physics_state(_delta:float):
	Singletons.PLAYER.CurrentSpeed = Singletons.PLAYER.WalkSpeed

func _input(event: InputEvent) -> void:
#// -> Sprint
	if event.is_action_pressed("Sprint") and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("SprintState")
#// -> Jump
	if event.is_action_pressed("Jump") and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("JumpState")
#// -> Sneak
	if event.is_action_pressed("Sneak") and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("SneakState")
		get_viewport().set_input_as_handled()
