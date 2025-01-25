extends Label


func start():
	$ErrorTimer.start()
	show()

func _on_error_timer_timeout() -> void:
	hide()
