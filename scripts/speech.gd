extends Label

var speech: String
var letter_counter: int

signal done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letter_counter = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_speech_timer_timeout() -> void:
	print_letter()
	print_letter()
	
func print_letter():
	if letter_counter == speech.length():
		done.emit()
		return
	
	# print next letter
	text += speech[letter_counter]
	letter_counter += 1
	
	
