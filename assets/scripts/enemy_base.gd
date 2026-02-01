extends CharacterBody2D

class_name EnemyBase
@onready var player = get_tree().get_first_node_in_group("player")

const RESCHEDULE_DESPAWN_TIME = 0.2

func _ready():
	despawn_after(get_life_time())

func despawn_after(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	if(player.isLookingAt(global_position)): # reschedule despawn because player is looking
		despawn_after(RESCHEDULE_DESPAWN_TIME)
		return
	queue_free()

func get_strength() -> int:
	push_error("get_strength() not implemented")
	return 0

func get_life_time() -> float:
	push_error("get_life_time() not implemented")
	return 0

func getDirectionToPlayer():
	return (player.global_position - global_position).normalized()

func getDirectionFromPlayer():
	return -getDirectionToPlayer()	

func getDistanceToPlayer():
	return global_position.distance_to(player.global_position)
