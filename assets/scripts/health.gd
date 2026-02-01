extends Node2D

@export var max_health: float = 100
@onready var audio = $AudioStreamPlayer;
var _current_health


func _ready() -> void:
	_current_health = max(0, max_health)
	_update_max_health_ui()
	_update_current_health_ui()


func _update_max_health_ui():
	Global.OnMaxHealthChange.emit(max_health)


func _update_current_health_ui():
	Global.OnCurrentHealthChange.emit(_current_health)
	
	
func get_health():
	return _current_health


func update_current_health(health_diff: float):
	_current_health = clamp(_current_health + health_diff, 0, max_health)
	audio.play();
	_update_current_health_ui()
