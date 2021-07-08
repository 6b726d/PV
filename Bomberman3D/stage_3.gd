extends Spatial


var enemys = 1

func _ready():
	pass

func _process(delta):
	if $music.playing == false:
		$music.play()
