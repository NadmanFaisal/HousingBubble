extends CanvasLayer


@export var speech: String
signal speech_ended


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !speech:
		speech = $Speech.text
	start()

func start():
	$Speech.text = ""
	$Speech.speech = speech
	$SpeechTimer.start()
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_speech_done() -> void:
	$SpeechTimer.stop()
	$Portrait.speed = 0
	$DespawnTimer.start()
	

func _on_despawn_timer_timeout():
	speech_ended.emit()
	queue_free()
	
