extends State
class_name SprintState

var isSprintToggled : bool

func _enter_state() -> void:
	isSprintToggled = true

func _physics_state(_delta):
	if isSprintToggled and Singletons.PLAYER.InputDir != Vector2.ZERO and Singletons.PLAYER.is_on_floor():
		Singletons.PLAYER.CurrentSpeed = Singletons.PLAYER.SprintSpeed
		isSprintToggled = true
	else:
		Singletons.PLAYER.CurrentSpeed = Singletons.PLAYER.WalkSpeed
		isSprintToggled = false
#// -> Walk
	if !isSprintToggled and Singletons.PLAYER.is_on_floor() or Singletons.PLAYER.CurrentSpeed == Singletons.PLAYER.WalkSpeed:
		StateChanged.emit("WalkState")

func _input(event: InputEvent) -> void:
#// -> Jump
	if event.is_action_pressed("Jump") and Singletons.PLAYER.is_on_floor():
		StateChanged.emit("JumpState")

## Stamina Drain --------------
#if ResourceCore.Stamina > 0 and velocity != Vector3.ZERO and CurrentSpeed == SprintSpeed and isSprintToggled:
	#ResourceCore.Stamina -= ResourceCore.StaminaDrain * delta
#elif ResourceCore.Stamina < ResourceCore.MaxStamina and (InputDir == Vector2.ZERO or CurrentSpeed != SprintSpeed or !isSprintToggled):
	#ResourceCore.Stamina += ResourceCore.StaminaDrain * delta
