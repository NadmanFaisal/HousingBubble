extends Node2D

signal pop

var MAX_SPEED = 250
var MIN_SPEED = 150

var MAX_SCALE = 2.0
var MIN_SCALE = 0.5

var speed: int
var velocity: Vector2
var angle: float
var wiggle_amplitude = 5.0
var wiggle_frequency = 1.0
var time = 0.0
var xAxis

const SIN = 0
const NSIN = 1

var wiggle_direction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = randi_range(MIN_SPEED, MAX_SPEED)
	var bubbleScale = randf_range(MIN_SCALE, MAX_SCALE)
	
	velocity = Vector2.UP * speed / bubbleScale
	scale = Vector2.ONE * bubbleScale
	wiggle_direction = randi_range(SIN, NSIN)
	 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += delta * velocity 
	
	time += delta
	
	position.x += wiggle_amplitude * wiggle(wiggle_frequency * time)

func wiggle(value: float):
	if(wiggle_direction == SIN):
		return sin(value)
	else:
		return -sin(value)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pop.emit()
	queue_free()
