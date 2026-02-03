extends Control

# Variables
var Property
var FPS : String
# Imports
@onready var PropertyContainer = $MarginContainer/PropertyContainer

func _ready() -> void:
	#Singletons.Debug = self
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Debug"):
		visible = !visible

func _add_debug(key: String, Value, Order: int):
	var Target = PropertyContainer.find_child(key, true, false)
	if !Target:
		Target = Label.new()
		Target.name = key
		PropertyContainer.add_child(Target)
	Target.text = "%s : %s" % [key, str(Value)]
	PropertyContainer.move_child(Target, Order)

func _process(delta: float) -> void:
	if visible:
		FPS = "%.2f" % (1.0/delta)
		_add_debug("FPS", FPS, 0)
