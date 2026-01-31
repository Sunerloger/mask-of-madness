extends Control

var opacity = 0;
@onready var diedText := $TextureRect
# Called when the node enters the scene tree for the first time.
var fade_speed := 0.5  # How fast it fades in (1.0 = 1 second to fully visible)

func _ready() -> void:
	# Make the text fully transparent at start
	diedText.modulate.a = 0.0

func _process(delta: float) -> void:
	if opacity < 1.0:
		opacity += delta * fade_speed   
		if opacity > 1.0:
			opacity = 1.0               
		diedText.modulate.a = opacity   


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startMenu.tscn")
