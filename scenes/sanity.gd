extends Node2D

var _sanity = 100

func _update_sanity_ui():
	Global.OnSanityChange.emit(_sanity)

func get_sanity():
	return _sanity
	
func set_sanity(newSanity: float):
	_sanity = newSanity
	_update_sanity_ui()
	
func change_sanity(sanityChange: float):
	_sanity += sanityChange
	_update_sanity_ui()


func _on_timer_timeout() -> void:
	change_sanity(-1)
