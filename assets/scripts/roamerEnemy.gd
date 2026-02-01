extends EnemyBase

# movement speed of enemy
const SPEED = 200.0
# radius at which the enemy circles the player
const RADIUS = 200

@export var strength: int = 5
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.material.light_mode = 2

func get_strength():
	return strength

# this enemy circles the player at a fixed radius 
# if the player looks away it moves closer
func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	var dir_to_player = getDirectionToPlayer()

	# Perpendicular direction for circling
	var circle_dir = Vector2(-dir_to_player.y, dir_to_player.x)

	var move_dir: Vector2

	if playerIsLooking():
		# Orbit + push back to radius
		var radius_error = getDistanceToPlayer() - RADIUS
		move_dir = circle_dir + dir_to_player * clamp(radius_error / RADIUS, -1.0, 1.0)
	else:
		# Spiral inward
		move_dir = (circle_dir + dir_to_player).normalized()


	velocity = move_dir.normalized() * SPEED
	move_and_slide()

	# Face movement direction
	if global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
	elif global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false
