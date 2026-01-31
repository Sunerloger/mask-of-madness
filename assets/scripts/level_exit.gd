extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)
	
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		exit_level()

func exit_level():
	print("Player exited the level!")
	get_tree().change_scene_to_file("res://scenes/victoryScene.tscn")
