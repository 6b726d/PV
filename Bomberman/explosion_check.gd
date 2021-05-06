extends Area2D


# Declare member variables here.
#direction-> 1:left, 2:right, 3:up, 4:down
var direction : int = 0
var power : int = 0
var value : int = 128
var stop : bool = false
var once : bool = false
var explosion = load("res://explosion/explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_explosion_check_body_entered(body):
	if body.is_in_group("no_destructibles"):
		stop = true
	if body.is_in_group("destructibles"):
		once = true


func _on_timer_explosion_check_timeout():
	if (power > 0) and (stop == false):
		var explosion_new = explosion.instance()
		get_parent().add_child(explosion_new)
		explosion_new.global_position = position
		explosion_new.direction = direction
		explosion_new.power = power - 1
		explosion_new.once = once
	queue_free()
