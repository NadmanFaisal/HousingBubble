extends RigidBody2D

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
			if collided_object.is_in_group("Enemies"):
				collided_object.take_damage(damage)
				print("I collided with an enemy")
				queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
