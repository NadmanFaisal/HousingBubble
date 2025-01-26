extends Area2D

var speed: int
var damage: int
var direction: Vector2
var type: String

enum SPEEDS {CASTLE_SHOT = 1000, TOWER_SHOT = 300}
enum DAMAGE {CASTLE_SHOT = 100, TOWER_SHOT = 25}

const CASTLE_SHOT = "CASTLE_SHOT"
const TOWER_SHOT = "TOWER_SHOT"




func _ready() -> void:
	if(!type):
		push_error("no type provided")
	if(!direction):
		push_error("no direction provided")
	match type:
		TOWER_SHOT: 
			speed = SPEEDS.TOWER_SHOT
			damage = DAMAGE.TOWER_SHOT
		CASTLE_SHOT: 
			speed = SPEEDS.CASTLE_SHOT
			damage = DAMAGE.CASTLE_SHOT
		_: push_error("Unknown bullet type")
	direction = direction.normalized()
	print("ready")
	
func _process (delta: float) -> void:
	var velocity = direction * speed
	position += velocity * delta
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("despawn")
	queue_free()
