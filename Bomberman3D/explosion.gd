extends Area


#direction-> 1:left, 2:right, 3:forward, 4:backward
var direction = 0
var power = 0
var once = false
#type-> 1:player, 2:enemy
var type = 0
var rng = RandomNumberGenerator.new()
var item_power = preload("res://items/item_power.tscn")
var explosion_check = load("res://player/explosion_check.tscn")

func _ready():
	rng.randomize()

func _on_timer_explosion_timeout():
	if once == false:
		var explosion_new = explosion_check.instance()
		get_parent().add_child(explosion_new)
		if direction == 0:
			explosion_new.global_transform = global_transform
		elif direction == 1:
			explosion_new.global_transform = $dir_left.global_transform
			explosion_new.direction = direction
		elif direction == 2:
			explosion_new.global_transform = $dir_right.global_transform
			explosion_new.direction = direction
		elif direction == 3:
			explosion_new.global_transform = $dir_forward.global_transform
			explosion_new.direction = direction
		elif direction == 4:
			explosion_new.global_transform = $dir_backward.global_transform
			explosion_new.direction = direction
		explosion_new.power = power
		explosion_new.type = type


func _on_explosion_body_entered(body):
	if body.is_in_group("destructibles"):
		var rand_num = rng.randi_range(0,3)
		if rand_num == 2:
			var item_power_new = item_power.instance()
			get_parent().add_child(item_power_new)
			item_power_new.global_transform = global_transform
		body.queue_free()
	if body.is_in_group("enemys"):
		if (type == 1):
			if (body.inmune == false):
				if body.lives > 1 :
					body.lives -= 1
					body.inmune = true
					body.timer.start()
				else:
					body.get_parent().enemys -= 1
					body.queue_free()
	if body.is_in_group("players"):
		print("Game Over")
		#get_tree().change_scene("res://map/menu.tscn")


func _on_timer_explosion_destroy_timeout():
	queue_free()
