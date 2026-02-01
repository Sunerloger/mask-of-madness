extends CharacterBody2D

class_name EnemyBase
@onready var player = get_tree().get_first_node_in_group("player")

func get_strength() -> int:
	push_error("get_strength() not implemented")
	return 0

func getDirectionToPlayer():
	return (player.global_position - global_position).normalized()

func getDirectionFromPlayer():
	return -getDirectionToPlayer()	

func getDistanceToPlayer():
	return global_position.distance_to(player.global_position)
