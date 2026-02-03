extends State
class_name IdleState

func _process_state(_delta: float):
#// -> Walk
	if Singletons.PLAYER.InputDir != Vector2.ZERO and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("WalkState")

func _input(event: InputEvent) -> void:
#// -> Jump
	if event.is_action_pressed("Jump") and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("JumpState")
#// -> Sneak
	if event.is_action_pressed("Sneak") and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("SneakState")
		get_viewport().set_input_as_handled()
