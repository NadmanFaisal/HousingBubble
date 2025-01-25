extends CharacterBody2D

const bulletPath = preload("res://scenes/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("I am shooting")
		shoot()
	

func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position


func _on_timer_timeout() -> void:
	print("I am being shot automatically")
	shoot()
