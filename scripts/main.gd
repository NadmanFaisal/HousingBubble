extends Node

signal damage_bubble(damage: int)
signal kill_counter_update(kill_count: int)
signal money_update(money: int)
signal not_enough_money

@export var goonScene: PackedScene
@export var tower_scene: PackedScene
@export var boss_scene: PackedScene
@export var speech_scene: PackedScene
@export var carScene: PackedScene
@export var adScene: PackedScene

var goons_defeated: int
var money: int
var build_mode: bool
var boss_battle: bool

var speech_stage1
var speech_stage2
var speech_stage3

const stage1_text = "Get a taste of some super cars."
const stage2_text = "You've got some new notifications from Y: (almost) everything app."
const stage3_text = "Jokes over, I'm activating my NeuroLunk™"

var stage1_started: bool
var stage2_started: bool
var stage3_started: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speech_stage1 = speech_scene.instantiate()
	speech_stage1.speech = stage1_text
	speech_stage1.speech_ended.connect(_on_stage1_speech_end)
	
	speech_stage2 = speech_scene.instantiate()
	speech_stage2.speech = stage2_text
	speech_stage2.speech_ended.connect(_on_stage2_speech_end)
	
	speech_stage3 = speech_scene.instantiate()
	speech_stage3.speech = stage3_text
	speech_stage3.speech_ended.connect(_on_stage3_speech_end)
	
	start_game()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_label_pressed(KEY_SPACE) and !boss_battle:
		boss_battle = true
		start_boss_battle()
		
	if Input.is_key_label_pressed(KEY_P):
		_on_ads_spawn_timer_timeout()
		

func start_game():
	goons_defeated = 0
	money = 0
	build_mode = false
	boss_battle = false
	$GoonSpawnerPath/GoonTimer.start()


func _on_goon_timer_timeout() -> void:
	if stage1_started:
		var car = carScene.instantiate()
		spawn_goon(car)
	else:
		var goon = goonScene.instantiate()
		spawn_goon(goon)
	
func spawn_goon(goon: Node):
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
	
	
func start_boss_battle():
	$GoonSpawnerPath/GoonTimer.stop()
	#todo: play animation
	var boss = boss_scene.instantiate()
	
	var spawner = $GoonSpawnerPath/GoonSpawner
	spawner.progress_ratio = randf()
	
	boss.position = spawner.position
	
	boss.stage2.connect(start_stage2_speech)
	boss.stage3.connect(start_stage3_speech)
	
	add_child(boss)
	add_child(speech_stage1)
	

func _on_stage1_speech_end():
	start_stage1()

func _on_stage2_speech_end():
	# stage starts at the same time as speech
	pass
	
func _on_stage3_speech_end():
	start_stage3()
	_on_stage_3_timer_timeout()

func start_stage1():
	stage1_started = true
	$GoonSpawnerPath/GoonTimer.start()
	
func start_stage2_speech():
	add_child(speech_stage2)
	start_stage2()

func start_stage2():
	stage2_started = true
	$AdsSpawnerPath/AdsSpawnTimer.start()
	_on_ads_spawn_timer_timeout()

func start_stage3_speech():
	add_child(speech_stage3)
	
func start_stage3():
	stage3_started = true
	$Stage3Timer.start()
	
func victory():
	$GoonSpawnerPath/GoonTimer.stop()
	$AdsSpawnerPath/AdsSpawnTimer.stop()
	$Stage3Timer.stop()
	#todo: load victory screen

func _on_ads_spawn_timer_timeout() -> void:
	var ad = adScene.instantiate()
	
	var spawner = $AdsSpawnerPath/AdsSpawner
	spawner.progress_ratio = randf()
	
	ad.position = spawner.position
	
	ad.scale *= randf_range(0.75, 2.0)
	
	add_child(ad)


func _on_stage_3_timer_timeout() -> void:
	var boss = get_node("Boss")
	if !boss:
		return
	var points = [$laserTest1.position, $laserTest2.position, $laserTest3.position]
	var rand = randi_range(0, 2)
	var start = points[rand]
	var dir = (-points[rand] + points[(rand+1) % 3]).normalized()
	boss.shoot_lasers(start, dir)
