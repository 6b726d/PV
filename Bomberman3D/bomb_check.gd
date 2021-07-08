extends Area


var power = 0
var stop = false
var bomb = preload("res://player/bomb.tscn")

func _ready():
	pass

func _on_bomb_check_body_entered(body):
	if body.is_in_group("objects"):
		stop = true

func _on_bomb_check_timer_timeout():
	if stop == false:
		var bomb_new = bomb.instance()
		bomb_new.power = power
		get_parent().add_child(bomb_new)
		bomb_new.global_transform = global_transform
	queue_free()
