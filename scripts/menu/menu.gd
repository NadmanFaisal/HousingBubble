extends Node

var game = preload("res://scenes/main.tscn").instantiate()
var chill_guy_animation = preload("res://scenes/chill-cutscene.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_chill_guy_function()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_chill_guy_function(): 
	add_child(chill_guy_animation)
	print("Timer Started")
	$ChillGuyTimer.start()

func _on_start_pressed() -> void:
	get_tree().root.add_child(game)
	queue_free()

func _on_chill_guy_timer_timeout() -> void:
	remove_child(chill_guy_animation)
	$ChillGuyTimer.stop()
	$AudioStreamPlayer2D.play()
	
