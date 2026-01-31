extends Node2D


const PICKUP_SCENE = preload("res://scenes/healthPickup.tscn")
@export var spawn_size := Vector2(400, 200)

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func spawnHealthPickup():
	var pickup = PICKUP_SCENE.instantiate()
	
	var half := spawn_size * 0.5
	var local_pos := Vector2(
		rng.randf_range(-half.x, half.x),
		rng.randf_range(-half.y, half.y)
	)

	pickup.global_position = to_global(local_pos)

	get_parent().get_parent().get_node("Spawnables").add_child(pickup)


func _on_timer_timeout() -> void:
	spawnHealthPickup()
