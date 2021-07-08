extends RigidBody


var power = 0
#type-> 1:player, 2:enemy
var type = 0
var explosion_check = load("res://player/explosion_check.tscn")
onready var explosion_audio : AudioStreamPlayer3D = get_node("explosion_audio")

func _ready():
	pass

func _on_bomb_timer_timeout():
	var explosion_center = explosion_check.instance()
	explosion_center.power = 1
	get_parent().add_child(explosion_center)
	explosion_center.global_transform = global_transform
	var explosion_left = explosion_check.instance()
	explosion_left.direction = 1
	explosion_left.power = power
	explosion_left.type = 1
	get_parent().add_child(explosion_left)
	explosion_left.global_transform = $dir_left.global_transform
	var explosion_right = explosion_check.instance()
	explosion_right.direction = 2
	explosion_right.power = power
	explosion_right.type = 1
	get_parent().add_child(explosion_right)
	explosion_right.global_transform = $dir_right.global_transform
	var explosion_forward = explosion_check.instance()
	explosion_forward.direction = 3
	explosion_forward.power = power
	explosion_forward.type = 1
	get_parent().add_child(explosion_forward)
	explosion_forward.global_transform = $dir_forward.global_transform
	var explosion_backward = explosion_check.instance()
	explosion_backward.direction = 4
	explosion_backward.power = power
	explosion_backward.type = 1
	get_parent().add_child(explosion_backward)
	explosion_backward.global_transform = $dir_backward.global_transform
	explosion_audio.play()
	yield(explosion_audio,"finished")
	queue_free()
