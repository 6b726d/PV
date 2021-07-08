extends Spatial


func _ready():
	pass

func _process(delta):
	if $music.playing == false:
		$music.play()
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene("res://map/stage_1.tscn")
	if Input.is_action_just_pressed("back"):
		get_tree().quit()
