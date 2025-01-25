extends Node

signal damage_bubble(damage: int)
signal kill_counter_update(kill_count: int)
signal money_update(money: int)
signal not_enough_money

@export var goonScene: PackedScene
@export var tower_scene: PackedScene

var goons_defeated: int
var money: int
var build_mode: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	goons_defeated = 0
	money = 0
	build_mode = false
	$GoonSpawnerPath/GoonTimer.start()


func _on_goon_timer_timeout() -> void:
	var goon = goonScene.instantiate()
	goon.add_to_group("Enemies")
	goon.damage_bubble.connect(_on_goon_damage_bubble)
	goon.death.connect(_on_goon_death)
	var goon_spawner = $GoonSpawnerPath/GoonSpawner
	goon_spawner.progress_ratio = randf()
	
	goon.position = goon_spawner.position
	add_child(goon)

func _on_goon_damage_bubble(damage: int):
	emit_signal("damage_bubble", damage)

func _on_goon_death():
	goons_defeated += 1
	money += 1
	kill_counter_update.emit(goons_defeated)
	money_update.emit(money)

func _on_build_tower():
	if(money >= 5):
		money -= 5
		money_update.emit(money)
		build_mode = true
		print("Build mode entered.")
	else:
		not_enough_money.emit()
	
func _input(event):
	if build_mode and event is InputEventMouseButton and event.pressed:
		place_tower(event.position)
	
func place_tower(position: Vector2):
	var tower = tower_scene.instantiate()
	
	add_child(tower)
	tower.global_position = position
	print("Tower placed at: ", position)
	
	build_mode = false
