extends State
class_name MovementStateMachine

@export var CurrentState : State
var MovementStates : Dictionary = {}

func _ready() -> void:
	for Child in get_children():
		if Child is State:
			MovementStates[Child.name] = Child
			Child.StateChanged.connect(_change_state)
			print(Child)
		else:
			print("Failed to Add State: " + str(Child))
	CurrentState._enter_state()

func _process(delta: float) -> void:
	if CurrentState:
		CurrentState._process_state(delta)

func _physics_process(delta: float) -> void:
	if CurrentState:
		CurrentState._physics_state(delta)

func _input(event: InputEvent) -> void:
	if CurrentState:
		CurrentState._input(event)

func _change_state(NewStateName: StringName) -> void:
	var NewState = MovementStates.get(NewStateName)
	if NewState == null:
		push_warning("State does not exist: " + str(NewStateName))
		return
	if NewState == CurrentState:
		return
	CurrentState._exit_state()
	NewState._enter_state()
	CurrentState = NewState
