extends EnemyBase

const SPEED = 30.0
const TP_DISTANCE = 200
const ZIGZAG_MIN_DISTANCE = 200
const ZIGZAG_ROTATION_ANGLE = 0.7
var ZIGZAG_DIRECTION = 1
@onready var player = get_tree().get_first_node_in_group("player")
@export var strength: int = 3

func _physics_process(delta: float) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	look_at(player.global_position)
	move_and_slide()

func _on_timer_timeout():
	var direction = getPlayerDirection()
	if(isFarFromPlayer()):
		direction = direction.rotated(ZIGZAG_ROTATION_ANGLE * ZIGZAG_DIRECTION)
	teleport(direction.normalized() * TP_DISTANCE)
	ZIGZAG_DIRECTION *= -1
	
func get_strength():
	return strength

func teleport(tp_vector):
	global_position += tp_vector
	
func getPlayerDirection():
	return (player.global_position - global_position).normalized()
	
func getPlayerDistance():
	return global_position.distance_to(player.global_position)
	
func isFarFromPlayer():
	return getPlayerDistance() > ZIGZAG_MIN_DISTANCE
