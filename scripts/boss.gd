extends Area2D
signal dropped_currency
signal damage_bubble(damage: int)
signal death
signal stage2
signal stage3


@export var max_health = 6000
const STAGE2_MILESTONE = 0.75	# hp% trigger for stage 2
const STAGE3_MILESTONE = 0.2		# hp% trigger for stage 3


var laser_speed = 1000

@export var speed = 30
@export var damage = 5
@export var attack_speed = 1.0
@export var currency = 1
var health: int

var stage2_started = false
var stage3_started = false


var insideBubble = false

var shooting = false
var laser_direction: Vector2

var bubble_position
var target_position
@onready var bubble = get_parent().get_node("TheBubble")

var screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health =  max_health
	$AttackSpeed.wait_time = attack_speed
	screen = get_viewport_rect().end
	print("Screen ", screen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_key_pressed(KEY_L) and !shooting:
		#var start = get_parent().get_node("laserTest1").global_position
		#var direction = get_parent().get_node("laserTest2").global_position - get_parent().get_node("laserTest1").global_position
		#direction = direction.normalized()
		#shoot_lasers(start, direction)
	
	if shooting:
		$LeftEye/leftLaser.points[1] += delta * laser_speed * laser_direction
		$RightEye/rightLaser.points[1] += delta * laser_speed * laser_direction
		var x = $LeftEye/leftLaser.points[1].x + position.x
		var y = $LeftEye/leftLaser.points[1].y + position.y
		print(x, y)
		if x > screen.x or x < 0 or y > screen.y or y < 0:
			stop_shooting()
	
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
	
func shoot_lasers(start: Vector2, direction: Vector2):
	var left_eye = $LeftEye.position
	var right_eye = $RightEye.position
	
	var eye_dist = abs(left_eye.x - right_eye.x)
	
	var left_laser = Vector2(start.x + eye_dist / 2, start.y) - position
	var right_laser = Vector2(start.x - eye_dist / 2, start.y) - position

	
	
	$LeftEye/leftLaser.points[1] = left_laser
	$RightEye/rightLaser.points[1] = right_laser
	
	$LeftEye/leftLaser.show()
	$RightEye/rightLaser.show()
	laser_direction = direction
	shooting = true

func stop_shooting():
	shooting = false
	$LeftEye/leftLaser.hide()
	$RightEye/rightLaser.hide()
	


func _on_laser_hitbox_body_entered(body: Node2D) -> void:
	body.queue_free()
