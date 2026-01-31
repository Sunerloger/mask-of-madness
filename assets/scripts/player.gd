extends CharacterBody2D


const SPEED = 300.0
@onready var occluder := $PointLight2D/LightOccluder2D

var facing_direction: Vector2

const TARGET_Y_SCALE := 2.0
const DURATION := 10.0

var elapsed := 0.0
var start_scale_y := 1.0

func _ready():
	start_scale_y = occluder.scale.y

func _physics_process(delta: float) -> void:
	facing_direction = (get_global_mouse_position() - global_position).normalized()
	
	if elapsed < DURATION:
		elapsed += delta
		var t := elapsed / DURATION
		occluder.scale.y = lerp(start_scale_y, TARGET_Y_SCALE, t)

	velocity = Vector2(0,0)
	look_at(get_global_mouse_position())
	var direction := Input.get_axis("Left", "Right")
	var up_down := Input.get_axis("Up", "Down")
	if direction:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	elif up_down:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	
	move_and_slide()
