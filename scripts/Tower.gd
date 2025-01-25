extends CharacterBody2D

@export var bulletScene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("I am shooting")
		shoot()
	

func shoot():
	var enemies = get_tree().get_nodes_in_group("Enemies")
	if enemies.size() > 0:
		var bullet = bulletScene.instantiate()
		
		bullet.position = $Position2D.global_position
		bullet.direction = (enemies[0].global_position - bullet.position).normalized()
		bullet.type = "TOWER_SHOT"
		
		get_parent().add_child(bullet)
	else:
		print("All enemies killed")



func _on_timer_timeout() -> void:
	shoot()
