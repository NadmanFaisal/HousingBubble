extends CharacterBody2D

var constantMovementVelocity = Vector2(1, 0)
var speed = 1000

func _physics_process(delta):
	var collision_info = move_and_collide(constantMovementVelocity.normalized() * delta * speed)
