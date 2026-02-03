extends State
class_name ActionStateMachine

@export var CurrentState : State
var ActionStates : Dictionary = {}

func _ready() -> void:
	for Child in get_children():
		if Child is State:
			ActionStates[Child.name] = Child
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
	var NewState = ActionStates.get(NewStateName)
	if NewState != CurrentState:
		CurrentState._exit_state()
		NewState._enter_state()
		CurrentState = NewState
	else:
		push_warning("State does not Exist")
