extends KinematicBody


var power = 2
var speed = 2
var lives = 1
var inmune = false
var rng = RandomNumberGenerator.new()
var rand_num = 0
var movement = Vector3()
onready var timer = $timer_inmune
var explosion_check = load("res://player/explosion_check.tscn")
onready var explosion_audio : AudioStreamPlayer3D = get_node("explosion_audio")

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

func _on_timer_inmune_timeout():
	inmune = false

func _on_timer_explosion_timeout():
	inmune = true
	var explosion_left = explosion_check.instance()
	explosion_left.direction = 1
	explosion_left.power = power
	explosion_left.type = 2
	get_parent().add_child(explosion_left)
	explosion_left.global_transform = $dir_left.global_transform
	var explosion_right = explosion_check.instance()
	explosion_right.direction = 2
	explosion_right.power = power
	explosion_right.type = 2
	get_parent().add_child(explosion_right)
	explosion_right.global_transform = $dir_right.global_transform
	var explosion_forward = explosion_check.instance()
	explosion_forward.direction = 3
	explosion_forward.power = power
	explosion_forward.type = 2
	get_parent().add_child(explosion_forward)
	explosion_forward.global_transform = $dir_forward.global_transform
	var explosion_backward = explosion_check.instance()
	explosion_backward.direction = 4
	explosion_backward.power = power
	explosion_backward.type = 2
	get_parent().add_child(explosion_backward)
	explosion_backward.global_transform = $dir_backward.global_transform
	explosion_audio.play()
	yield(explosion_audio,"finished")
	timer.start()
