extends CanvasLayer

@export var tower_scene: PackedScene
var is_build_mode = false
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
	
func update_money(money) -> void:
	$MoneyLabel.text = "Money: " + str(money)+"$"
	


func _on_build_tower_button_pressed() -> void:
	is_build_mode = true
	print("Build mode entered.")
	
func _input(event):
	if is_build_mode and event is InputEventMouseButton and event.pressed:
		place_tower(event.position)

func place_tower(position: Vector2):
	if not tower_scene:
		print("No tower scene assigned.")
		return
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.global_position = position
	print("Tower placed at: ", position)
	is_build_mode = false
	

func _on_timer_timeout() -> void:
	print("Removing animation")
	remove_child(animation_instance)
	$Timer.stop()
