extends Area2D
signal damaged(by)
signal killed

var enemyInsideBubble = null

const HP_MAX = 100.0
var hp = HP_MAX
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
