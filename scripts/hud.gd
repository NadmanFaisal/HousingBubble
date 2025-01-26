extends CanvasLayer

signal money_update(money: int)
signal build_tower

var animation_instance = preload("res://scenes/rootCutscene.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
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
	build_tower.emit()
	

func _on_main_money_update(money: int) -> void:
	$MoneyLabel.text = "Money: " + str(money)+"$"


func _on_main_not_enough_money() -> void:
	$NotEnoughMoney.start()
func _on_timer_timeout() -> void:
	print("Removing animation")
	remove_child(animation_instance)
	$Timer.stop()
