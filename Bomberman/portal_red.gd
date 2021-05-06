extends Area2D


# Declare member variables here.
export (PackedScene) var scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_portal_red_body_entered(body):
	if body.is_in_group("players"):
		if body.get_parent().enemys == 0:
			get_tree().change_scene_to(scene)
