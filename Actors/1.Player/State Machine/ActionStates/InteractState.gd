extends State
class_name InteractState

@onready var InteractTime: Timer = $Timer

signal Interacted()

func _enter_state():
	InteractTime.start()
	var InteractTarget =  Singletons.PLAYER.CameraRay.get_collider()
	if InteractTarget == null:
		print("No Interactable Node Found!")
	elif InteractTarget.has_node("isInteractable"):
		var InteractNode = InteractTarget.get_node("isInteractable")
		InteractNode._interact_toggle()
	else:
		print("Selected Node is Null.")

func _on_timer_timeout() -> void:
		StateChanged.emit("IdleActionState")
