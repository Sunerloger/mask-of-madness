extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("reached 1")
	print("entered:", body.name, " groups:", body.get_groups())
	if body.is_in_group("player"):
		print("reached 2")
		var health := body.get_node("Health")
		health.update_current_health(5)
		queue_free()
