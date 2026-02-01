extends AudioStreamPlayer2D

@export var tracks: Array = [
	preload("res://assets/sounds/growl_1.mp3"),
	preload("res://assets/sounds/growl_2.mp3"),
	preload("res://assets/sounds/growl_3.mp3")
]

func _on_finished() -> void:
	await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
	stream = tracks.pick_random()
	play()
