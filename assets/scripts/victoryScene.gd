extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSettings.gameStarted = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startMenu.tscn")
