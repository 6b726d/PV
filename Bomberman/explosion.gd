extends Area2D


# Declare member variables here.
#direction-> 1:left, 2:right, 3:up, 4:down
var direction : int = 0
var power : int = 0
var value : int = 128
var once : bool = false
var rng = RandomNumberGenerator.new()
var item_power = preload("res://items/item_power.tscn")
var explosion_check = load("res://explosion/explosion_check.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timer_explosion_timeout():
	if once == false:
		var explosion_new = explosion_check.instance()
		get_parent().add_child(explosion_new)
		if direction == 0:
			explosion_new.global_position = position
		elif direction == 1:
			explosion_new.global_position = Vector2(position.x - value, position.y)
			explosion_new.direction = direction
		elif direction == 2:
			explosion_new.global_position = Vector2(position.x + value, position.y)
			explosion_new.direction = direction
		elif direction == 3:
			explosion_new.global_position = Vector2(position.x, position.y - value)
			explosion_new.direction = direction
		elif direction == 4:
			explosion_new.global_position = Vector2(position.x, position.y + value)
			explosion_new.direction = direction
		explosion_new.power = power


func _on_explosion_body_entered(body):
	if body.is_in_group("destructibles"):
		#scale_0.5 begin
		var pos_x = position.x * 2
		var pos_y = position.y * 2
		#escale_0.5 end
		#tiles begin
		var tile = body.world_to_map(Vector2(pos_x, pos_y))
		body.set_cell(tile.x, tile.y, -1)
		#tiles end
		#item begin
		var rand_num = rng.randi_range(0,3)
		if rand_num == 2:
			var item_power_new = item_power.instance()
			get_parent().add_child(item_power_new)
			item_power_new.global_position = position
		#item end
	if body.is_in_group("enemys"):
		if (body.inmune == false):
			if body.lives > 1 :
				body.lives -= 1
				body.inmune = true
				body.timer.start()
			else:
				body.get_parent().enemys -= 1
				body.queue_free()
	if body.is_in_group("players"):
		#print("Game Over")
		get_tree().change_scene("res://menu/menu.tscn")


func _on_time_explosion_destroy_timeout():
	queue_free()
