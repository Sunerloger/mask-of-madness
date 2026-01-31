extends Node2D

@export var max_sanity: float = 100
var _current_sanity = 100


func _ready() -> void:
	_current_sanity = max(0, max_sanity)
	_update_max_sanity_ui()
	_update_current_sanity_ui()


func _update_max_sanity_ui():
	Global.OnMaxSanityChange.emit(max_sanity)


func _update_current_sanity_ui():
	Global.OnCurrentSanityChange.emit(_current_sanity)


func get_sanity():
	return _current_sanity
	
	
func set_sanity(new_sanity: float):
	_current_sanity = clamp(new_sanity, 0, max_sanity)
	_update_current_sanity_ui()
	
	
func update_current_sanity(sanity_change: float):
	_current_sanity = clamp(_current_sanity + sanity_change, 0, max_sanity)
	_update_current_sanity_ui()


func _on_timer_timeout() -> void:
	update_current_sanity(-1)
