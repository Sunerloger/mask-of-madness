extends EnemyBase

# movememnt speed of enemy
const SPEED = 200.0
# radius at which the enemy circles the player
const RADIUS = 200

@export var strength: int = 5

@onready var player = get_tree().get_first_node_in_group("player")

func get_strength():
	return strength

# this enemy circles the player at a fixed radius 
# if the player looks away it moves closer
func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	var to_player = player.global_position - global_position
	var distance = to_player.length()
	var dir_to_player = to_player.normalized()

	# Perpendicular direction for circling
	var circle_dir = Vector2(-dir_to_player.y, dir_to_player.x)

	# Check if player is looking at enemy
	var from_player = -dir_to_player
	var look_dot = player.facing_direction.dot(from_player)
	var player_looking = look_dot > 0.3

	var move_dir: Vector2

	if player_looking:
		# Orbit + push back to radius
		var radius_error = distance - RADIUS
		move_dir = circle_dir + dir_to_player * clamp(radius_error / RADIUS, -1.0, 1.0)
	else:
		# Spiral inward
		move_dir = (circle_dir + dir_to_player).normalized()


	velocity = move_dir.normalized() * SPEED
	move_and_slide()

	# Face movement direction
	look_at(player.global_position)
