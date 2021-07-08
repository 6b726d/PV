extends Area


onready var item_audio : AudioStreamPlayer3D = get_node("item_audio")

func _ready():
	pass

func _on_item_power_body_entered(body):
	if body.is_in_group("players"):
		body.power += 1
		item_audio.play()
		yield(item_audio,"finished")
		queue_free()


func _on_timer_power_timeout():
	queue_free()
