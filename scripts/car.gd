extends Area2D
signal dropped_currency
signal damage_bubble(damage: int)
signal death

@export var speed = 500
@export var health = 100
@export var damage = 5
@export var attack_speed = 1.0
@export var currency = 1


var insideBubble = false

var bubble_position
@onready var bubble = get_parent().get_node("TheBubble")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackSpeed.wait_time = attack_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	bubble_position = bubble.position
	var direction = (bubble_position - position).normalized()
	var direction_rotated = Vector2(-direction.y, direction.x)
	direction = (direction + 3 * direction_rotated).normalized()
	

	if position.distance_to(bubble_position) > 3:
		position += direction * speed * delta

func take_damage(amount: int):
	print("Im taking damage")
	health -= amount
	if health <= 0:
		die()

func _on_area_entered(area: Area2D) -> void:
	print("body entereed")
	
	# if collided with Castle
	if area.get_collision_layer_value(2):
		emit_signal("damage_bubble", damage)
		$AttackSpeed.start()
	
	# if collided with bullet
	if area.get_collision_layer_value(4):
		var bullet = area
		print(bullet)
		take_damage(bullet.damage)
		bullet.queue_free()
		


func _on_area_exited(area: Area2D) -> void:
	$AttackSpeed.stop()
	insideBubble = false

func die():
	death.emit()
	emit_signal("dropped_currency", currency)
	queue_free()
	

func _on_attack_speed_timeout() -> void:
	damage_bubble.emit(damage)
