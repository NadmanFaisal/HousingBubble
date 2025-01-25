extends CharacterBody2D

@export var speed = 100
var bubble_position
var target_position
@export var health = 100
@onready var bubble = get_parent().get_node("TheBubble")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("mobs")

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	bubble_position = bubble.position
	target_position = (bubble_position - position).normalized()

	if position.distance_to(bubble_position) > 3:
		position += target_position * speed * delta
