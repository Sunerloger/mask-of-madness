extends Node2D

func _on_timer_timeout() -> void:
	Global.OnSanityChange.emit(-1)
