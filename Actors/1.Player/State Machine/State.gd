extends Node3D
class_name State

signal StateChanged

func _enter_state():
	set_process_input(true)

func _process_state(_delta: float):
	pass

func _exit_state():
	set_process_input(false)
	pass

func _physics_state(_delta: float):
	pass

func _input(_event: InputEvent):
	pass
