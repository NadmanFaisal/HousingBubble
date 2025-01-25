extends Area2D

const BULLET_SPEED= 1000
@export var direction: Vector2

func _ready() -> void:
	pass
	
func _process (delta: float) -> void:
	var velocity = direction * BULLET_SPEED
	position += velocity * delta
	
	
#func _on_Bubble_Bullet_body_entered(body: Node) -> void:
	#emit_signal("hit_target", body)
	#queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("despawn")
	queue_free()
