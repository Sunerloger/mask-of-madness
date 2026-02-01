extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_destroyed: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_destroyed:
		is_destroyed = true
		var sanity = body.get_node("Sanity")
		sanity.update_current_sanity(5)
		
		visible = false
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
