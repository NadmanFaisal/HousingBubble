extends Node2D

@export var bubbleScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BubbleTimer.start()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bubble_timer_timeout() -> void:
	var bubble = bubbleScene.instantiate()
	
	var spawnerLocation = $BubblePath/BubbleSpawner
	spawnerLocation.progress_ratio = randf()
	
	bubble.position = spawnerLocation.position
	add_child(bubble)
	
	
	
