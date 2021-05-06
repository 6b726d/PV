extends KinematicBody2D

# Declare member variables here.
var size : int = 64
export var speed : int = 3
export var power : int = 1
var movement : Vector2 = Vector2()
onready var sprite = $sprt_player
onready var timer = $timer_player
var bomb = preload("res://bomb/bomb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	speed *= size
	
func _input(event):
	if Input.is_action_pressed("plant_bomb") and timer.is_stopped():
		timer.start()
		var bomb_new = bomb.instance()
		bomb_new.power = power
		get_parent().add_child(bomb_new)
		bomb_new.global_position = position
		bomb_new.add_collision_exception_with(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		sprite.rotation_degrees = 90
		movement.y = 0
		movement.x = -speed * delta
		move_and_collide(movement)
	if Input.is_action_pressed("move_right"):
		sprite.rotation_degrees = 270
		movement.y = 0
		movement.x = speed * delta
		move_and_collide(movement)
	if Input.is_action_pressed("move_up"):
		sprite.rotation_degrees = 180
		movement.x = 0
		movement.y = -speed * delta
		move_and_collide(movement)
	if Input.is_action_pressed("move_down"):
		sprite.rotation_degrees = 0
		movement.x = 0
		movement.y = speed * delta
		move_and_collide(movement)
