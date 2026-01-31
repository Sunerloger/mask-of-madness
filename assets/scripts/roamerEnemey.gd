extends CharacterBody2D

const SPEED = 200.0
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	look_at(player.global_position)
	move_and_slide()
