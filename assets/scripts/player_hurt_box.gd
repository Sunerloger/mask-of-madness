extends Area2D


func _on_body_entered(body: Node2D) -> void:
	var enemy := body as EnemyBase
	if enemy:
		var healthNode = get_parent().get_node("Health")
		healthNode.update_current_health(-enemy.get_strength())

	# TODO get_overlapping_bodies()
