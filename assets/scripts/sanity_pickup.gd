extends Area2D


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var sanity = body.get_node("Sanity")
		sanity.update_current_sanity(5)
		audio_stream_player_2d.play()
		queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
