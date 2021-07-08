extends KinematicBody


var path = []
var path_node = 0
var power = 4
var speed = 2
var lives = 4
var inmune = false
onready var nav = $"../Navigation"
onready var player = $"../player"
onready var timer = $timer_inmune
var explosion_check = load("res://player/explosion_check.tscn")
onready var explosion_audio : AudioStreamPlayer3D = get_node("explosion_audio")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if path_node < path.size():
		var dir = path[path_node] - global_transform.origin
		if dir.length() < 1:
			path_node += 1
		else:
			look_at(player.global_transform.origin, Vector3.UP)
			move_and_slide(dir.normalized() * speed, Vector3.UP)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_enemy_timer_timeout():
	move_to(player.global_transform.origin)

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
