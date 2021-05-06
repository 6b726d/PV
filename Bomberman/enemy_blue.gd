extends KinematicBody2D


# Declare member variables here.
var size : int = 64
export var lives : int = 1
export var speed : int = 2
export var inmune : bool = false
var rng = RandomNumberGenerator.new()
var rand_num : int = 0
var movement : Vector2 = Vector2()
onready var sprite = $sprt_enemy_blue
onready var timer = $timer_enemy_blue


func move_left(delta):
	sprite.rotation_degrees = 90
	movement.y = 0
	movement.x = -speed * delta

func move_right(delta):
	sprite.rotation_degrees = 270
	movement.y = 0
	movement.x = speed * delta

func move_up(delta):
	sprite.rotation_degrees = 180
	movement.x = 0
	movement.y = -speed * delta

func move_down(delta):
	sprite.rotation_degrees = 0
	movement.x = 0
	movement.y = speed * delta

# Called when the node enters the scene tree for the first time.
func _ready():
	speed *= size
	rand_num = rng.randi_range(1,4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (rand_num == 1):
		move_left(delta)
	elif (rand_num == 2):
		move_right(delta)
	elif (rand_num == 3):
		move_up(delta)
	elif (rand_num == 4):
		move_down(delta)
	var collision = move_and_collide(movement)
	if collision:
		rand_num = rng.randi_range(1,4)
		if collision.collider.is_in_group("players"):
			#print("Game Over")
			get_tree().change_scene("res://menu/menu.tscn")


func _on_timer_enemy_blue_timeout():
	inmune = false
