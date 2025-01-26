extends CanvasLayer

signal money_update(money: int)
signal build_tower
signal finish_cutscene

var animation_instance = preload("res://scenes/rootCutscene.tscn").instantiate()
var audio_players: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_random_theme_song()
	

func play_random_theme_song():
	audio_players = [$AudioStreamPlayer2D, $AudioStreamPlayer2D2]
	var random_index = randi() % audio_players.size()
	audio_players[random_index].play()
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if Input.is_action_just_pressed("ui_accept"):
	pass

func start_cutscene():
	print("Melon Eusk being called")
	add_child(animation_instance)
	$Timer.start()

func _on_instance_timer_timeout(instance: Node) -> void:
	if instance:
		instance.queue_free()
		print("Instance removed by timer.")



func _on_the_bubble_damaged(by: Variant) -> void:
	$bubbleHP.value -= by


func _on_the_bubble_killed() -> void:
	pass # Replace with function body.
	

func _on_build_tower_button_pressed() -> void:
	var money_text = $MoneyLabel.text
	if money_text.begins_with("Money: "):
		var amount = int(money_text.replace("Money: ", "").replace("$", ""))
		if amount >= 5:
			$AudioStreamPlayer2D3.play()
		
	
	build_tower.emit()
	

func _on_main_money_update(money: int) -> void:
	$MoneyLabel.text = "Money: " + str(money)+"$"


func _on_main_not_enough_money() -> void:
	$NotEnoughMoney.start()

func _on_timer_timeout() -> void:
	print("Removing animation")
	remove_child(animation_instance)
	$Timer.stop()
	finish_cutscene.emit()
	
