extends KinematicBody


var speed = 2
var lives = 2
var inmune = false
var rng = RandomNumberGenerator.new()
var rand_num = 0
var movement = Vector3()
onready var timer = $timer_inmune

func move1(delta):
	rotation_degrees.y = 270
	movement.z = 0
	movement.x = -speed * delta

func move2(delta):
	rotation_degrees.y = 90
	movement.z = 0
	movement.x = speed * delta

func move3(delta):
	rotation_degrees.y = 180
	movement.x = 0
	movement.z = -speed * delta

func move4(delta):
	rotation_degrees.y = 0
	movement.x = 0
	movement.z = speed * delta

func _ready():
	rand_num = rng.randi_range(1,4)
	
func _physics_process(delta):
	if (rand_num == 1):
		move1(delta)
	elif (rand_num == 2):
		move2(delta)
	elif (rand_num == 3):
		move3(delta)
	elif (rand_num == 4):
		move4(delta)
	var collision = move_and_collide(movement)
	if collision:
		rand_num = rng.randi_range(1,4)
		if collision.collider.is_in_group("players"):
			print("Game Over")
			#get_tree().change_scene("res://map/menu.tscn")

func _on_timer_enemy_inmune_timeout():
	inmune = false
