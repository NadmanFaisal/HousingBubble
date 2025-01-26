extends Area2D
signal dropped_currency
signal damage_bubble(damage: int)
signal death
signal stage2
signal stage3


@export var max_health = 1000
const STAGE2_MILESTONE = 0.75	# hp% trigger for stage 2
const STAGE3_MILESTONE = 0.2		# hp% trigger for stage 3


@export var speed = 50
@export var damage = 5
@export var attack_speed = 1.0
@export var currency = 1
var health: int

var stage2_started = false
var stage3_started = false


var insideBubble = false

var bubble_position
var target_position
@onready var bubble = get_parent().get_node("TheBubble")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health =  max_health
	$AttackSpeed.wait_time = attack_speed

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
	if !stage2_started && health <= max_health * STAGE2_MILESTONE:
		stage2.emit()
		stage2_started = true
	if !stage3_started && health <= max_health * STAGE3_MILESTONE:
		stage3.emit()
		stage3_started = true
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
