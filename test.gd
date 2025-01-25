extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var camera = get_node("Camera2D")
	camera.offset = Vector2(0,0)
	camera.position = $Bubble.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
