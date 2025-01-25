extends CharacterBody2D

var constantMovementVelocity = Vector2(1, 0)
@export var speed = 300
@export var damage = 25
var target_position = Vector2.ZERO
var direction = Vector2.ZERO

func fire(target: Vector2):
	target_position = target
	direction = (target_position - position).normalized()

func _physics_process(delta):
	if target_position != Vector2.ZERO:
		var collision_info = move_and_collide(direction * speed * delta)
		if collision_info:
			var collided_object = collision_info.get_collider()
			if collided_object.is_in_group("mobs"):
				collided_object.take_damage(damage)
				print("I collided with a mob")
				queue_free()
				
		if position.distance_to(target_position) > 2000:
			queue_free()
