extends CharacterBody2D

var constantMovementVelocity = Vector2(1, 0)
@export var speed = 300
@export var damage = 25
var target_position = Vector2.ZERO

func fire(target: Vector2):
	target_position = target

func _physics_process(delta):
	if target_position != Vector2.ZERO:
		var direction = (target_position - position).normalized()
		var collision_info = move_and_collide(direction * speed * delta)
		if collision_info:
			var collided_object = collision_info.get_collider()
			if collided_object.is_in_group("mobs"):
				collided_object.take_damage(25)
				print("I collided with a mob")
				queue_free()
