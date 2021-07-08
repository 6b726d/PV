extends Area


export (PackedScene) var scene

func _ready():
	pass

func _on_portal_body_entered(body):
	if body.is_in_group("players"):
		if body.get_parent().enemys == 0:
			get_tree().change_scene_to(scene)
