extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var sanity = body.get_node("Sanity")
		sanity.update_current_sanity(5)
		queue_free()
