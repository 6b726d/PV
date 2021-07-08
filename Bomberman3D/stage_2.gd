extends Spatial


var enemys = 4

func _ready():
	pass

func _process(delta):
	if $music.playing == false:
		$music.play()
