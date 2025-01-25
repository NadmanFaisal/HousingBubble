extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_kill_counter_update(kill_count: int) -> void:
	text = "Goons Defeated: " + str(kill_count)
