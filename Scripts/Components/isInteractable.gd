extends Node3D
class_name Interactable

# This script can be added onto a blank node to give its parent the **Interactable** trait.

@export var InteractName : String
@export var Trigger : bool = false
@export var AnimPlayer: AnimationPlayer
@export var InteractAnimOn : String
@export var InteractAnimOff : String

func _interact_toggle():
	if !Trigger:
		Trigger = !Trigger
		AnimPlayer.play(InteractAnimOn)
		print("Can Interact: ", Trigger)
	elif Trigger:
		Trigger = !Trigger
		AnimPlayer.play(InteractAnimOff)
		print("Can Interact: ", Trigger)
