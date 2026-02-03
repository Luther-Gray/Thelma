extends State
class_name JumpState

var ExtraJump = 1
@export var DoubleJumpReq : int = 50

@onready var VarSprint: SprintState = $"../SprintState"

func _enter_state() -> void:
	Singletons.PLAYER.velocity.y = Singletons.PLAYER.JumpHeight

func _unhandled_input(_event: InputEvent) -> void:
	# Double Jump Check
	if Input.is_action_just_pressed("Jump") and Singletons.PLAYER.Attributes.Alacrity >= DoubleJumpReq and ExtraJump > 0 and !Singletons.PLAYER.is_on_floor():
		Singletons.PLAYER.velocity.y = Singletons.PLAYER.JumpHeight
		ExtraJump -= 1

func _physics_state(_delta) -> void:
	if Singletons.PLAYER.is_on_floor() and !VarSprint.isSprintToggled:
		Singletons.PLAYER.Attributes._grant_xp("Alacrity", Singletons.PLAYER.JumpHeight)
		StateChanged.emit("WalkState")

	if Singletons.PLAYER.is_on_floor() and VarSprint.isSprintToggled:
		Singletons.PLAYER.Attributes._grant_xp("Alacrity", (Singletons.PLAYER.JumpHeight + round(Singletons.PLAYER.velocity.y)))
		StateChanged.emit("SprintState")

func _exit_state() -> void:
	ExtraJump = 1
	pass
