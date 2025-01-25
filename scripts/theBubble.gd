extends Area2D
signal damaged(by)
signal killed

var enemyInsideBubble = null
signal bubblePosition(bubPos)

var screen_size
@export var bulletScene: PackedScene
var mouse

const HP_MAX = 100.0
var hp = HP_MAX
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("damageBubble"):
		take_damage()
	emit_signal("bubblePosition", global_position)
	if Input.is_action_just_pressed("shoot"):
		var mouse_position = get_viewport().get_mouse_position()
		shoot()
		emit_signal("bubblePosition", global_position)

func take_damage(amount: int):
	var prev_hp = hp
	hp -= amount
	if prev_hp != hp:
		emit_signal("damaged", amount)
	if hp <= 0.0:
		emit_signal("killed")

func _on_mob_damage_bubble(amount: Variant) -> void:
	print("potato")
	take_damage(amount)
func shoot():
	print("spawned")
	var bullet = bulletScene.instantiate()
	bullet.position = Vector2.ZERO
	
	var mouse_position = get_viewport().get_mouse_position()
	print(mouse_position)
	bullet.direction = (mouse_position-position).normalized()
	
	
	
	
	add_child(bullet)
	
	#var mouse_position = get_global_mouse_position()
	#var direction = (mouse_position - global_position).normalize()
	#bullet.position = $Marker2D.global_position
	#bullet.set_direction(direction)
	#print(global_position) 

	
