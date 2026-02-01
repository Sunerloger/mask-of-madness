extends AudioStreamPlayer2D


func _on_finished() -> void:
	await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
	play()
