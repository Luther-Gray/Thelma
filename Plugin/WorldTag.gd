class_name WorldTag
extends EditorPlugin

@export var Position: Vector3
@export var Scene: String
@export var Title: String
@export_multiline var Description: String
@export var Picture: Texture2D
@export var Video: String
@export var Complete: bool = false
@export var Priority: int = 1
@export var Tags: Array[String]
