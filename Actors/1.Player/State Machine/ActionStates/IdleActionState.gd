extends State
class_name ActionIdleState

#//-> Interaction State
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		StateChanged.emit("InteractState")
