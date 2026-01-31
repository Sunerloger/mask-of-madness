extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var health := body.get_node("Health")
		health.update_current_health(5)
		queue_free()
