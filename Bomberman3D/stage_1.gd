extends Spatial


var enemys = 3

func _ready():
	pass

func _process(delta):
	if $music.playing == false:
		$music.play()
