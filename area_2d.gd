extends Area2D
signal damaged(by)
signal killed()
signal bubblePosition(bubPos)
var screen_size

const HP_MAX = 100.0
var hp = HP_MAX
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("damageBubble"):
		take_damage()
	emit_signal("bubblePosition", global_position)

func take_damage():
	var damage = 10.0
	var prev_hp = hp
	hp -= damage
	if prev_hp != hp:
		emit_signal("damaged", damage)
	if hp <= 0.0:
		emit_signal("killed")
