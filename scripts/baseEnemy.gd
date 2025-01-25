extends Area2D
signal dropped_currency
signal damage_bubble

@export var speed = 300
@export var health = 100
@export var damage = 5
@export var attack_speed = 1.0
@export var currency = 1

var insideBubble = false

var bubble_position
var target_position
@onready var bubble = get_parent().get_node("TheBubble")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackSpeed.wait_time = attack_speed
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	bubble_position = bubble.position
	target_position = (bubble_position - position).normalized()

	if position.distance_to(bubble_position) > 3:
		position += target_position * speed * delta

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func _on_area_entered(area: Area2D) -> void:
	print("body entereed")
	emit_signal("damage_bubble", damage)
	$AttackSpeed.start()
		


func _on_area_exited(area: Area2D) -> void:
	$AttackSpeed.stop()
	insideBubble = false

func die():
	emit_signal("dropped_currency", currency)
	queue_free()
	


func _on_attack_speed_timeout() -> void:
	emit_signal("damage_bubble", damage)
