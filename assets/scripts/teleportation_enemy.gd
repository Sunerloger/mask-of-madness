extends EnemyBase

var SPEED = 30.0
const MOVE_SPEED = 30
const LIFE_TIME = 40
const TP_DISTANCE = 150
const ZIGZAG_MIN_DISTANCE = 200
const ZIGZAG_ROTATION_ANGLE = 0.7
var ZIGZAG_DIRECTION = 1
@export var strength: int = 3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.material.light_mode = 2

func _physics_process(delta: float) -> void:
	if(player.isLookingAt(global_position)):
		SPEED = 0
	else:
		SPEED = MOVE_SPEED
	velocity = getDirectionToPlayer() * SPEED
		# Face movement direction
	if global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
	elif global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false
	move_and_slide()

# Teleportation timer
func _on_timer_timeout():
	if(player.isLookingAt(global_position)):
		return
	var direction = getDirectionToPlayer()
	if(isFarFromPlayer()): # stop zig zaging when really close to player 
		direction = direction.rotated(ZIGZAG_ROTATION_ANGLE * ZIGZAG_DIRECTION)
	teleport(direction.normalized() * TP_DISTANCE)
	ZIGZAG_DIRECTION *= -1
	
func get_strength():
	return strength
	
func get_life_time():
	return LIFE_TIME

func teleport(tp_vector):
	global_position += tp_vector
	
func isFarFromPlayer():
	return getDistanceToPlayer() > ZIGZAG_MIN_DISTANCE
