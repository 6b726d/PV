extends StaticBody2D


# Declare member variables here.
var power : int = 1
var value : int = 128
var explosion = load("res://explosion/explosion.tscn")
var explosion_check = load("res://explosion/explosion_check.tscn")
onready var explosion_audio : AudioStreamPlayer2D = get_node("explosion_audio2d")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timer_bomb_timeout():
	var explosion_center = explosion_check.instance()
	explosion_center.power = 1
	get_parent().add_child(explosion_center)
	explosion_center.global_position = position
	var explosion_left = explosion_check.instance()
	explosion_left.direction = 1
	explosion_left.power = power
	get_parent().add_child(explosion_left)
	explosion_left.global_position = Vector2(position.x - value, position.y)
	var explosion_right = explosion_check.instance()
	explosion_right.direction = 2
	explosion_right.power = power
	get_parent().add_child(explosion_right)
	explosion_right.global_position = Vector2(position.x + value, position.y)
	var explosion_up = explosion_check.instance()
	explosion_up.direction = 3
	explosion_up.power = power
	get_parent().add_child(explosion_up)
	explosion_up.global_position = Vector2(position.x, position.y - value)
	var explosion_down = explosion_check.instance()
	explosion_down.direction = 4
	explosion_down.power = power
	get_parent().add_child(explosion_down)
	explosion_down.global_position = Vector2(position.x, position.y + value)
	explosion_audio.play()
	yield(explosion_audio,"finished")
	queue_free()
