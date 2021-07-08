extends KinematicBody


onready var speed = 4
onready var acceleration = 8
onready var gravity = 9.8
onready var jump = 4
var mouse_sensitivity = 0.1
var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()
onready var timer = $player_bomb_check_timer
onready var bomb_pos = $player_bomb_check_pos
var power = 1
var bomb_check = preload("res://player/bomb_check.tscn")
onready var jump_audio : AudioStreamPlayer3D = get_node("jump_audio")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

func _process(delta):
	direction = Vector3()
	if not is_on_floor():
		fall.y -= gravity * delta
	if Input.is_action_just_pressed("jump"):
		fall.y = jump
		jump_audio.play()
		yield(jump_audio,"finished")
	if Input.is_action_just_pressed("plant_bomb") and timer.is_stopped():
		timer.start()
		var bomb_new = bomb_check.instance()
		bomb_new.power = power
		get_parent().add_child(bomb_new)
		bomb_new.global_transform = bomb_pos.global_transform
	if Input.is_action_just_pressed("back"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("move_left"):
		direction += transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_forward"):
		direction += transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction -= transform.basis.z
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
	if Input.is_action_just_pressed("first_person_camera"):
		if $CameraFP.current == false:
			$CameraTP.current = false
			$CameraVP.current = false
			$CameraFP.current = true
	if Input.is_action_just_pressed("third_person_camera"):
		if $CameraTP.current == false:
			$CameraFP.current = false
			$CameraVP.current = false
			$CameraTP.current = true
	if Input.is_action_just_pressed("view_person_camera"):
		if $CameraVP.current == false:
			$CameraFP.current = false
			$CameraTP.current = false
			$CameraVP.current = true
