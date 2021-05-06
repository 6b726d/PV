extends VBoxContainer


# Declare member variables here.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btn_story_pressed():
	get_tree().change_scene("res://story_maps/stg1_1.tscn")


func _on_btn_quit_pressed():
	get_tree().quit()
