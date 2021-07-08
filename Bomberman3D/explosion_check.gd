extends Area


#direction-> 1:left, 2:right, 3:forward, 4:backward
var direction = 0
var power = 0
var stop = false
var once = false
#type-> 1:player, 2:enemy
var type = 0
var explosion = load("res://player/explosion.tscn")

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


func _on_explosion_check_timer_timeout():
	if (power > 0) and (stop == false):
		var explosion_new = explosion.instance()
		get_parent().add_child(explosion_new)
		explosion_new.global_transform = global_transform
		explosion_new.direction = direction
		explosion_new.power = power - 1
		explosion_new.once = once
		explosion_new.type = type
	queue_free()
