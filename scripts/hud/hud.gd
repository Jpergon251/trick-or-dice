extends Control

@export var camera_view_texture: SubViewport

@onready var camera_view: Sprite3D = $CanvasLayer/CameraView

func _ready() -> void:
	camera_view.texture = camera_view_texture.get_texture()
